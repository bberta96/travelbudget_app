-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Már 03. 18:32
-- Kiszolgáló verziója: 10.4.17-MariaDB
-- PHP verzió: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `travelbudget_db`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add cost', 1, 'add_cost'),
(2, 'Can change cost', 1, 'change_cost'),
(3, 'Can delete cost', 1, 'delete_cost'),
(4, 'Can view cost', 1, 'view_cost'),
(5, 'Can add country', 2, 'add_country'),
(6, 'Can change country', 2, 'change_country'),
(7, 'Can delete country', 2, 'delete_country'),
(8, 'Can view country', 2, 'view_country'),
(9, 'Can add flight', 3, 'add_flight'),
(10, 'Can change flight', 3, 'change_flight'),
(11, 'Can delete flight', 3, 'delete_flight'),
(12, 'Can view flight', 3, 'view_flight'),
(13, 'Can add trip', 4, 'add_trip'),
(14, 'Can change trip', 4, 'change_trip'),
(15, 'Can delete trip', 4, 'delete_trip'),
(16, 'Can view trip', 4, 'view_trip'),
(17, 'Can add log entry', 5, 'add_logentry'),
(18, 'Can change log entry', 5, 'change_logentry'),
(19, 'Can delete log entry', 5, 'delete_logentry'),
(20, 'Can view log entry', 5, 'view_logentry'),
(21, 'Can add permission', 6, 'add_permission'),
(22, 'Can change permission', 6, 'change_permission'),
(23, 'Can delete permission', 6, 'delete_permission'),
(24, 'Can view permission', 6, 'view_permission'),
(25, 'Can add group', 7, 'add_group'),
(26, 'Can change group', 7, 'change_group'),
(27, 'Can delete group', 7, 'delete_group'),
(28, 'Can view group', 7, 'view_group'),
(29, 'Can add user', 8, 'add_user'),
(30, 'Can change user', 8, 'change_user'),
(31, 'Can delete user', 8, 'delete_user'),
(32, 'Can view user', 8, 'view_user'),
(33, 'Can add content type', 9, 'add_contenttype'),
(34, 'Can change content type', 9, 'change_contenttype'),
(35, 'Can delete content type', 9, 'delete_contenttype'),
(36, 'Can view content type', 9, 'view_contenttype'),
(37, 'Can add session', 10, 'add_session'),
(38, 'Can change session', 10, 'change_session'),
(39, 'Can delete session', 10, 'delete_session'),
(40, 'Can view session', 10, 'view_session');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$260000$WsJBZ7XJzTJPTnHw0Z8ouA$mrzf7vlV3KyIRJo+tmS8oi/PrNSuyxlfyshI0oZ/5gQ=', '2024-03-03 16:49:31.152295', 0, 'traveller', '', '', '', 0, 1, '2023-10-11 18:29:42.271863'),
(2, 'pbkdf2_sha256$260000$BAGWfQdqGduK5lLNL5kmdF$eDrnsiEmhTNfGeQ4xmyhuYuQxOa3RaW3Q1PyEMRikbE=', '2024-03-03 17:06:32.955163', 0, 'berta', '', '', '', 0, 1, '2023-10-11 20:06:52.656709'),
(4, 'pbkdf2_sha256$260000$UFH7QyMVWe0jglspXsnbXE$BBx8KN+Dxe53lcypbzm/F08UmpzbQHAg5EjtyAiS8I4=', '2024-03-03 17:11:22.817891', 0, 'newuser', '', '', '', 0, 1, '2023-10-13 17:51:32.779047');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cost_table`
--

CREATE TABLE `cost_table` (
  `id` bigint(20) NOT NULL,
  `flight_cost` int(11) NOT NULL,
  `hotel_cost` int(11) NOT NULL,
  `food_cost` int(11) NOT NULL,
  `fun_cost` int(11) NOT NULL,
  `travel_cost` int(11) NOT NULL,
  `visa_cost` int(11) NOT NULL,
  `vaccine_cost` int(11) NOT NULL,
  `other_cost` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `cost_table`
--

INSERT INTO `cost_table` (`id`, `flight_cost`, `hotel_cost`, `food_cost`, `fun_cost`, `travel_cost`, `visa_cost`, `vaccine_cost`, `other_cost`) VALUES
(9, 100, 70, 36, 30, 10, 0, 0, 5),
(10, 120, 100, 20, 12, 5, 0, 0, 5),
(11, 50, 25, 25, 25, 25, 0, 0, 0),
(12, 300, 80, 30, 20, 10, 0, 0, 12),
(13, 1500, 333, 33, 16, 33, 50, 100, 13),
(14, 200, 87, 30, 20, 20, 0, 0, 25),
(15, 668, 192, 78, 40, 56, 50, 0, 70),
(16, 120, 50, 40, 16, 9, 0, 0, 10),
(17, 111, 40, 36, 13, 12, 0, 0, 15),
(18, 44, 50, 12, 47, 35, 0, 0, 9),
(19, 572, 116, 58, 24, 33, 40, 50, 63),
(20, 1250, 139, 66, 31, 16, 40, 100, 10),
(21, 250, 150, 80, 23, 45, 0, 0, 50),
(22, 210, 12, 16, 7, 3, 0, 0, 2),
(23, 360, 117, 65, 18, 20, 0, 0, 25),
(24, 210, 100, 65, 32, 11, 0, 0, 27),
(25, 720, 185, 62, 18, 26, 25, 0, 19);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `country_table`
--

CREATE TABLE `country_table` (
  `id` bigint(20) NOT NULL,
  `country` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `country_table`
--

INSERT INTO `country_table` (`id`, `country`) VALUES
(1, 'Hungary'),
(2, 'Germany'),
(3, 'USA'),
(4, 'UK'),
(5, 'Iceland'),
(6, 'Norway'),
(7, 'France'),
(8, 'Spain'),
(9, 'China'),
(10, 'Japan'),
(11, 'Italy'),
(12, 'Australia');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(5, 'admin', 'logentry'),
(7, 'auth', 'group'),
(6, 'auth', 'permission'),
(8, 'auth', 'user'),
(9, 'contenttypes', 'contenttype'),
(10, 'sessions', 'session'),
(1, 'trips', 'cost'),
(2, 'trips', 'country'),
(3, 'trips', 'flight'),
(4, 'trips', 'trip');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2023-10-11 18:23:36.299768'),
(2, 'auth', '0001_initial', '2023-10-11 18:23:49.976760'),
(3, 'admin', '0001_initial', '2023-10-11 18:23:52.821434'),
(4, 'admin', '0002_logentry_remove_auto_add', '2023-10-11 18:23:52.876715'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2023-10-11 18:23:52.926829'),
(6, 'contenttypes', '0002_remove_content_type_name', '2023-10-11 18:23:53.701460'),
(7, 'auth', '0002_alter_permission_name_max_length', '2023-10-11 18:23:54.599436'),
(8, 'auth', '0003_alter_user_email_max_length', '2023-10-11 18:23:57.776407'),
(9, 'auth', '0004_alter_user_username_opts', '2023-10-11 18:23:57.848865'),
(10, 'auth', '0005_alter_user_last_login_null', '2023-10-11 18:23:58.535386'),
(11, 'auth', '0006_require_contenttypes_0002', '2023-10-11 18:23:58.571168'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2023-10-11 18:23:58.625211'),
(13, 'auth', '0008_alter_user_username_max_length', '2023-10-11 18:23:58.832071'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2023-10-11 18:23:59.001208'),
(15, 'auth', '0010_alter_group_name_max_length', '2023-10-11 18:23:59.931939'),
(16, 'auth', '0011_update_proxy_permissions', '2023-10-11 18:24:00.004065'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2023-10-11 18:24:00.119994'),
(18, 'sessions', '0001_initial', '2023-10-11 18:24:00.583957'),
(19, 'trips', '0001_initial', '2023-10-11 18:24:15.764333'),
(20, 'trips', '0002_alter_trip_user_id', '2023-10-11 18:53:21.757346'),
(21, 'trips', '0003_alter_flight_unique_together', '2023-10-21 15:25:00.366961');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('6zsc2c85odpajk8lr1s1ep7rinbfy6r6', 'e30:1qrKAe:vweUfIpJMsu9NdT_eI_tNadT8K9xeuLYyZ1brr22JTI', '2023-10-27 15:33:48.438861'),
('kw44e0wwuy53ljhx9qzhsnne68s2l1r9', '.eJxVjDEOwjAMRe-SGUV2k2LKyM4ZIseOaQG1UtNOiLtDpQ6w_vfef7nE69KntZY5DerOrnGH3y2zPMq4Ab3zeJu8TOMyD9lvit9p9ddJy_Oyu38HPdf-WzOqcgFjajQIdC2CEdJRYxPN0DoJIbaaRaGzSCYBRU9IRBEMAdz7A_oPN_I:1quG4R:XkQpcG1QD4pib9dQq7elJWSZ0Q2gCFmCWWYfkIZl5Qo', '2023-11-04 17:47:31.977837');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `flight_table`
--

CREATE TABLE `flight_table` (
  `id` bigint(20) NOT NULL,
  `destination_id` bigint(20) NOT NULL,
  `origin_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `flight_table`
--

INSERT INTO `flight_table` (`id`, `destination_id`, `origin_id`) VALUES
(5, 2, 1),
(14, 6, 2),
(18, 7, 3),
(8, 10, 3),
(10, 3, 4),
(15, 1, 5),
(6, 6, 5),
(9, 7, 5),
(17, 8, 6),
(11, 4, 7),
(16, 4, 8),
(7, 11, 8),
(13, 12, 11),
(12, 9, 12);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `trip_table`
--

CREATE TABLE `trip_table` (
  `id` bigint(20) NOT NULL,
  `number_of_days` int(11) NOT NULL,
  `number_of_travellers` int(11) NOT NULL,
  `trip_name` varchar(64) NOT NULL,
  `reverse` tinyint(1) NOT NULL,
  `cost_id_id` bigint(20) NOT NULL,
  `flight_id_id` bigint(20) NOT NULL,
  `user_id_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `trip_table`
--

INSERT INTO `trip_table` (`id`, `number_of_days`, `number_of_travellers`, `trip_name`, `reverse`, `cost_id_id`, `flight_id_id`, `user_id_id`) VALUES
(8, 7, 2, 'Trip 1', 0, 9, 5, 1),
(9, 4, 1, 'Trip 2', 1, 10, 5, 2),
(10, 2, 2, 'Summer trip', 0, 11, 6, 1),
(11, 5, 1, 'Winter trip', 0, 12, 7, 1),
(12, 6, 1, 'Business trip', 0, 13, 8, 2),
(13, 4, 1, 'Weekend 1', 0, 14, 9, 2),
(14, 7, 2, 'US summer', 0, 15, 10, 1),
(15, 5, 1, 'UK business', 0, 16, 11, 2),
(16, 4, 1, 'Volcano tour', 1, 17, 6, 2),
(17, 5, 2, 'Mediterran trip', 1, 18, 7, 2),
(18, 6, 1, 'Visit the great wall', 0, 19, 12, 1),
(19, 14, 2, 'Visit the coral reef', 0, 20, 13, 1),
(20, 8, 1, 'Aurora borealis', 0, 21, 14, 4),
(21, 5, 2, 'Hungarian holiday', 0, 22, 15, 4),
(22, 3, 1, 'London marathon', 0, 23, 16, 4),
(23, 4, 2, 'Bullfighting', 0, 24, 17, 4),
(24, 4, 1, 'Fashion week', 0, 25, 18, 4);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- A tábla indexei `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- A tábla indexei `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- A tábla indexei `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- A tábla indexei `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- A tábla indexei `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- A tábla indexei `cost_table`
--
ALTER TABLE `cost_table`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `country_table`
--
ALTER TABLE `country_table`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- A tábla indexei `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- A tábla indexei `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- A tábla indexei `flight_table`
--
ALTER TABLE `flight_table`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `flight_table_origin_id_destination_id_10fcb161_uniq` (`origin_id`,`destination_id`),
  ADD KEY `flight_table_destination_id_45aa7ab8_fk_country_table_id` (`destination_id`);

--
-- A tábla indexei `trip_table`
--
ALTER TABLE `trip_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trip_table_cost_id_id_d3b9eb15_fk_cost_table_id` (`cost_id_id`),
  ADD KEY `trip_table_flight_id_id_59ccddfe_fk_flight_table_id` (`flight_id_id`),
  ADD KEY `trip_table_user_id_id_b5317ef1_fk_auth_user_id` (`user_id_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT a táblához `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `cost_table`
--
ALTER TABLE `cost_table`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT a táblához `country_table`
--
ALTER TABLE `country_table`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT a táblához `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT a táblához `flight_table`
--
ALTER TABLE `flight_table`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT a táblához `trip_table`
--
ALTER TABLE `trip_table`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Megkötések a táblához `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Megkötések a táblához `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Megkötések a táblához `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Megkötések a táblához `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Megkötések a táblához `flight_table`
--
ALTER TABLE `flight_table`
  ADD CONSTRAINT `flight_table_destination_id_45aa7ab8_fk_country_table_id` FOREIGN KEY (`destination_id`) REFERENCES `country_table` (`id`),
  ADD CONSTRAINT `flight_table_origin_id_c4bd6b1a_fk_country_table_id` FOREIGN KEY (`origin_id`) REFERENCES `country_table` (`id`);

--
-- Megkötések a táblához `trip_table`
--
ALTER TABLE `trip_table`
  ADD CONSTRAINT `trip_table_cost_id_id_d3b9eb15_fk_cost_table_id` FOREIGN KEY (`cost_id_id`) REFERENCES `cost_table` (`id`),
  ADD CONSTRAINT `trip_table_flight_id_id_59ccddfe_fk_flight_table_id` FOREIGN KEY (`flight_id_id`) REFERENCES `flight_table` (`id`),
  ADD CONSTRAINT `trip_table_user_id_id_b5317ef1_fk_auth_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
