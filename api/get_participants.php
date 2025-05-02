<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=utf-8");
require_once '../db_connection.php';

try {
    $db = new Database();
    $conn = $db->getConnection();
    
    $stmt = $conn->query("SELECT * FROM participants ORDER BY registration_date DESC");
    $participants = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (empty($participants)) {
        echo json_encode(["message" => "Нет зарегистрированных участников"]);
    } else {
        echo json_encode($participants);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => "Ошибка базы данных: " . $e->getMessage()]);
}
?>