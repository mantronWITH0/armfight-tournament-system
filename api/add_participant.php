<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS, GET");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=utf-8");

require_once '../db_connection.php';

// Обработка OPTIONS-запроса (для CORS)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Обработка GET-запроса (для тестирования)
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    echo json_encode([
        'success' => false,
        'message' => 'Этот API-эндпоинт работает только с POST-запросами. Отправьте JSON-данные.'
    ]);
    exit();
}

// Обработка POST-запроса
try {
    $input = json_decode(file_get_contents('php://input'), true);
    
    if (json_last_error() !== JSON_ERROR_NONE || !$input) {
        throw new Exception("Неверный формат JSON-данных");
    }

    // Проверка обязательных полей
    $required = ['last_name', 'first_name'];
    foreach ($required as $field) {
        if (empty($input[$field])) {
            throw new Exception("Поле '$field' обязательно для заполнения");
        }
    }

    $db = new Database();
    $conn = $db->getConnection();

    $stmt = $conn->prepare("
        INSERT INTO participants 
        (last_name, first_name, birth_date, gender, weight_category, contact_phone, email)
        VALUES (:last_name, :first_name, :birth_date, :gender, :weight_category, :contact_phone, :email)
    ");

    $stmt->execute([
        ':last_name' => $input['last_name'],
        ':first_name' => $input['first_name'],
        ':birth_date' => $input['birth_date'] ?? null,
        ':gender' => $input['gender'] ?? null,
        ':weight_category' => $input['weight_category'] ?? null,
        ':contact_phone' => $input['contact_phone'] ?? null,
        ':email' => $input['email'] ?? null
    ]);

    echo json_encode([
        'success' => true,
        'participant_id' => $conn->lastInsertId(),
        'message' => 'Участник успешно добавлен'
    ]);

} catch (Exception $e) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'message' => 'Ошибка: ' . $e->getMessage()
    ]);
}
?>