<?php
class Database {
    private $host = "localhost";
    private $db_name = "armfight_db";
    private $username = "root"; // Стандартный пользователь XAMPP
    private $password = "";     // Пароль по умолчанию пустой
    public $conn;

    public function getConnection() {
        $this->conn = null;
        try {
            $this->conn = new PDO(
                "mysql:host=" . $this->host . ";dbname=" . $this->db_name . ";charset=utf8mb4", 
                $this->username, 
                $this->password
            );
            $this->conn->exec("set names utf8");
        } catch(PDOException $exception) {
            echo "Ошибка подключения: " . $exception->getMessage();
        }
        return $this->conn;
    }
}
?>