-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Май 03 2025 г., 07:03
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `armfight_db`
--

-- --------------------------------------------------------

--
-- Структура таблицы `participants`
--

CREATE TABLE `participants` (
  `id` int(11) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `birth_date` date NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `weight_category` varchar(20) NOT NULL,
  `contact_phone` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `registration_date` datetime DEFAULT current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `participants`
--

INSERT INTO `participants` (`id`, `last_name`, `first_name`, `middle_name`, `birth_date`, `gender`, `weight_category`, `contact_phone`, `email`, `registration_date`, `is_active`) VALUES
(1, 'Шипицин', 'Алексей', NULL, '2003-12-26', 'male', '55', '902144018409', 'nyamkotik@gmail.com', '2025-05-03 01:46:09', 1),
(2, 'Шипицин', 'Алексей1', NULL, '2222-02-22', 'male', '55', '902144018409', '', '2025-05-03 01:46:25', 1),
(3, 'Шипицин', 'Алексей', NULL, '2222-02-11', 'female', '77', '902144018409', 'nyamkotik@gmail.com', '2025-05-03 02:12:18', 1),
(4, 'Шипицин', 'Алексей', NULL, '2222-02-21', 'male', '54', '89148009886', 'montron777@gmail.com', '2025-05-03 02:13:27', 1),
(5, 'Шипицин', 'Алексей', NULL, '0000-00-00', 'male', '130', '902144018409', 'nyamkotik@gmail.com', '2025-05-03 02:19:17', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `participant_documents`
--

CREATE TABLE `participant_documents` (
  `id` int(11) NOT NULL,
  `participant_id` int(11) NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `document_number` varchar(50) NOT NULL,
  `issue_date` date DEFAULT NULL,
  `issuing_authority` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `participant_medical_info`
--

CREATE TABLE `participant_medical_info` (
  `id` int(11) NOT NULL,
  `participant_id` int(11) NOT NULL,
  `medical_insurance` varchar(50) DEFAULT NULL,
  `medical_contraindications` text DEFAULT NULL,
  `last_medical_check` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `participants`
--
ALTER TABLE `participants`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `participant_documents`
--
ALTER TABLE `participant_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `participant_id` (`participant_id`);

--
-- Индексы таблицы `participant_medical_info`
--
ALTER TABLE `participant_medical_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `participant_id` (`participant_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `participants`
--
ALTER TABLE `participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `participant_documents`
--
ALTER TABLE `participant_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `participant_medical_info`
--
ALTER TABLE `participant_medical_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `participant_documents`
--
ALTER TABLE `participant_documents`
  ADD CONSTRAINT `participant_documents_ibfk_1` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `participant_medical_info`
--
ALTER TABLE `participant_medical_info`
  ADD CONSTRAINT `participant_medical_info_ibfk_1` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
