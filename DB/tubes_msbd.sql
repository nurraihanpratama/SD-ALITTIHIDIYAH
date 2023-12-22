-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 21, 2023 at 11:46 AM
-- Server version: 5.7.33
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tubes_msbd`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_admin` (IN `nama` VARCHAR(255), IN `NUPTK` CHAR(18), IN `pass` VARCHAR(255), IN `tgl_masuk` DATE, IN `jk` CHAR(2), IN `admin` CHAR(36))   BEGIN
        
            DECLARE errno INT;
            DECLARE uuid CHAR(36);
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
            DECLARE EXIT HANDLER for SQLWARNING
            BEGIN
                ROLLBACK;
            END;
        
            SET uuid = UUID();
        
            START TRANSACTION;
            INSERT INTO users(uuid, username, password, created_at, updated_at) 
            VALUES (uuid, NUPTK, pass, NOW(), NOW());
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(admin, "insert", "users", NOW());
        
            INSERT INTO user_profiles(user, nama, jenis_kelamin, created_at, updated_at)
            VALUES (uuid, nama, jk, NOW(), NOW());
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(admin, "insert", "user_profiles", NOW());
        
            INSERT INTO gurus(NUPTK, user, jabatan, tanggal_masuk, status, created_at, updated_at)
            VALUES(NUPTK, uuid, "tu", tgl_masuk, "aktif", NOW(), NOW());
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(admin, "insert", "gurus", NOW());
        
            INSERT INTO model_has_roles(role_id, model_type, model_id)
            VALUES ("3", "App\\Models\\User", uuid);
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(admin, "insert", "model_has_roles", NOW());
            COMMIT;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_ekstrakurikuler` (IN `admin` CHAR(36), IN `ekstrakurikuler` CHAR(5), IN `nama` VARCHAR(30), IN `hari` CHAR(6), IN `waktu_mulai` TIME, IN `waktu_akhir` TIME, IN `tempat` VARCHAR(100), IN `kelas` CHAR(1))   BEGIN
                DECLARE errno INT;
                DECLARE uuid CHAR(36);
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                BEGIN
                    ROLLBACK;
                END;
            
                SET uuid = UUID();
            
                START TRANSACTION;
                INSERT INTO ekstrakurikulers(ekstrakurikuler_id, nama, hari, waktu_mulai, waktu_akhir, tempat, kelas,  created_at, updated_at) 
                VALUES (ekstrakurikuler, nama, hari, waktu_mulai, waktu_akhir, tempat, kelas, NOW(), NOW());

                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(admin, "insert", "ekstrakurikulers", NOW());
                
                COMMIT;
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_ekstrakurikuler_siswa` (IN `admin` CHAR(36), IN `ekstrakurikuler` CHAR(5), IN `siswa` VARCHAR(10), IN `ta` CHAR(9))   BEGIN
                DECLARE errno INT;
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                BEGIN
                    ROLLBACK;
                END;
            
                START TRANSACTION;
                INSERT INTO ekstrakurikuler_siswas(ekstrakurikuler, siswa, tahun_ajaran_aktif, created_at) 
                VALUES (ekstrakurikuler, siswa, ta, NOW());

                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(admin, "insert", "ekstrakurikuler_siswas", NOW());
                
                COMMIT;
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_guru` (IN `nama` VARCHAR(255), IN `NUPTK` CHAR(18), IN `pass` VARCHAR(255), IN `tgl_masuk` DATE, IN `jk` CHAR(2), IN `actor` CHAR(36))   BEGIN
        
            DECLARE errno INT;
            DECLARE uuid CHAR(36);
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
            DECLARE EXIT HANDLER for SQLWARNING
            BEGIN
                ROLLBACK;
            END;
        
            SET uuid = UUID();
        
            START TRANSACTION;
            INSERT INTO users(uuid, username, password, created_at, updated_at) 
            VALUES (uuid, NUPTK, pass, NOW(), NOW());
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "insert", "users", NOW());
        
            INSERT INTO user_profiles(user, nama, jenis_kelamin, created_at, updated_at)
            VALUES (uuid, nama, jk, NOW(), NOW());
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "insert", "user_profiles", NOW());
        
            INSERT INTO gurus(NUPTK, user, jabatan, tanggal_masuk, status, created_at, updated_at)
            VALUES(NUPTK, uuid, "guru", tgl_masuk, "aktif", NOW(), NOW());
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "insert", "gurus", NOW());

            INSERT INTO model_has_roles(role_id, model_type, model_id)
            VALUES ("4", "App\\Models\\User", uuid);

            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "insert", "model_has_roles", NOW());
            COMMIT;
        
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_kelas` (IN `kelas_id` CHAR(6), IN `nama` VARCHAR(255), IN `urutan` CHAR(1), IN `kelompok` CHAR(1), `actor` CHAR(36))   BEGIN

                DECLARE errno INT;
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
                        ROLLBACK;
                    END;

                START TRANSACTION;
            
                INSERT INTO kelas(kelas_id, nama_kelas, grade, kelompok_kelas, created_at, updated_at)
                VALUES(kelas_id, nama, urutan, kelompok, NOW(), NOW());
            
                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(actor, "insert", "kelas", NOW());

                COMMIT;
            
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_kelas_aktif` (IN `kelas` CHAR(6), IN `wali` CHAR(18), IN `ta` CHAR(9), IN `admin` CHAR(36))   BEGIN

                DECLARE errno INT;
                DECLARE nama_kelas_aktif VARCHAR(255);
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
                        ROLLBACK;
                    END;

                START TRANSACTION;

                SELECT nama_kelas INTO nama_kelas_aktif FROM kelas WHERE kelas_id = kelas COLLATE utf8mb4_general_ci;
            
                INSERT INTO kelas_aktifs(kelas_aktif_id, kelas, wali_kelas, tahun_ajaran_aktif, nama_kelas_aktif, created_at, updated_at)
                VALUES(UUID(), kelas, wali, ta, nama_kelas_aktif, NOW(), NOW());
            
                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(actor, "insert", "kelas_aktifs", NOW());

                COMMIT;
            
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_mapel` (IN `mapel` CHAR(5), IN `nama` VARCHAR(255), IN `kelompok` CHAR(1), IN `kkm` INTEGER, IN `krklm` VARCHAR(255), IN `admin` CHAR(36))   BEGIN

                DECLARE errno INT;
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                BEGIN
                    ROLLBACK;
                END;
                START TRANSACTION;
            
                INSERT INTO mapels(mapel_id, nama_mapel, kelompok_mapel, kkm, kurikulum, created_at, updated_at)
                VALUES (mapel, nama, kelompok, kkm, krklm, NOW(), NOW());
            
                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(admin, "insert", "mapels", NOW());

                COMMIT;
            
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_mapel_guru` (IN `mapel` CHAR(5), IN `guru` CHAR(16), IN `actor` CHAR(36))   BEGIN
            DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;

            START TRANSACTION;

            INSERT INTO mapel_gurus(mapel, guru, created_at) 
            VALUES (mapel, guru, NOW());

            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "insert", "mapel_gurus", NOW());
            
            COMMIT;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_nilai` (IN `sesi` INT, IN `jenis` CHAR(3), IN `mapel` CHAR(5), IN `guru` CHAR(16), IN `kontrak` INT, IN `nilai_p` FLOAT, IN `deskripsi_p` TEXT, IN `nilai_k` FLOAT, IN `deskripsi_k` TEXT, IN `user` CHAR(36))   BEGIN

                DECLARE kkm_nilai INT;
                DECLARE start DATETIME;
                DECLARE end DATETIME;

                SELECT kkm INTO kkm_nilai FROM mapels WHERE mapel_id = mapel COLLATE utf8mb4_general_ci ;
                SELECT tanggal_mulai INTO start FROM sesi_penilaians WHERE sesi_id = sesi;
                SELECT tanggal_berakhir INTO end FROM sesi_penilaians WHERE sesi_id = sesi;

                IF cek_sesi(start, end) = 1 THEN
                    INSERT INTO nilais(sesi, mapel, guru, kontrak_siswa, jenis, kkm_aktif, nilai_pengetahuan, deskripsi_pengetahuan, nilai_keterampilan, deskripsi_keterampilan, status, created_at, updated_at)
                    VALUES(sesi, mapel, guru, kontrak, jenis, kkm_nilai, nilai_p, deskripsi_p, nilai_k, deskripsi_k, "pending", NOW(), NOW());
                    INSERT INTO log_activities(actor, action, at, created_at)
                    VALUES(user, "insert", "nilai", NOW());
                ELSE
                    SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT ="Sesi tidak tersedia";
                END IF;

            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_permission` (IN `nama` VARCHAR(255), IN `user` CHAR(36))   BEGIN
        
            DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
        
            START TRANSACTION;
            INSERT INTO permissions(name, guard_name, created_at, updated_at) 
            VALUES (nama, "web", NOW(), NOW());
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(user, "insert", "permissions", NOW());
            
            COMMIT;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_prestasi` (IN `nisn` CHAR(10), IN `jenis` VARCHAR(12), IN `ket` TEXT, IN `tgl` DATE, IN `admin` CHAR(36))   BEGIN
                DECLARE errno INT;
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                BEGIN
                    ROLLBACK;
                END;
            
                START TRANSACTION;
                INSERT INTO prestasis(siswa, jenis_prestasi, keterangan, tanggal_prestasi)
                VALUES(nisn, jenis, ket, tgl);
            
                 INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(admin, "insert", "prestasis", NOW());
                COMMIT;
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_role` (IN `nama` VARCHAR(255), IN `user` CHAR(36))   BEGIN
        
            DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
        
            START TRANSACTION;
            INSERT INTO roles(name, guard_name, created_at, updated_at) 
            VALUES (nama, "web", NOW(), NOW());
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(user, "insert", "roles", NOW());
            
            COMMIT;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_roster` (IN `mapel` INT, IN `kelas_aktif` CHAR(36), IN `tahun_ajaran` CHAR(9), IN `semester` CHAR(6), IN `waktu_mulai` TIME, IN `waktu_akhir` TIME, IN `hari` CHAR(6), IN `actor` CHAR(36))   BEGIN
                DECLARE errno INT;
                DECLARE actor CHAR(36);
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                BEGIN
                    ROLLBACK;
                END;

                SET actor = UUID();

                START TRANSACTION;

                INSERT INTO rosters(mapel_guru, kelas, tahun_ajaran_aktif, semester_aktif, waktu_mulai, waktu_akhir, hari, created_at, updated_at) 
                VALUES (mapel, kelas_aktif, tahun_ajaran, semester, waktu_mulai, waktu_akhir, hari, NOW(), NOW());

                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(actor, "insert", "rosters", NOW());
                
                COMMIT;
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_sesi` (IN `sesi` CHAR(3), IN `ta` CHAR(9), IN `semester` CHAR(6), IN `start` DATETIME, IN `end` DATETIME, IN `admin` CHAR(36))   BEGIN
        
        INSERT INTO sesi_penilaians(nama_sesi, tahun_ajaran_aktif, semester_aktif, tanggal_mulai, tanggal_berakhir, created_at, updated_at)
        VALUES(sesi, ta, semester, start, end, NOW(), NOW());
        
        INSERT INTO log_activities(actor, action, at, created_at)
        VALUES(admin, "insert", "sesi_penilaians", NOW());
        
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_siswa` (IN `nama` VARCHAR(255), IN `nisn` CHAR(10), IN `nis` CHAR(4), IN `pass` VARCHAR(255), IN `tgl_masuk` DATE, IN `ta` CHAR(9), IN `kelas_aktif` CHAR(36), IN `kelas_awal` CHAR(2), IN `semester` CHAR(6), IN `jk` CHAR(2), IN `actor` CHAR(36))   BEGIN

            DECLARE uuid CHAR(36);
            DECLARE grade_kelas CHAR(1);

            SET uuid = UUID();
            SELECT kelas.grade INTO grade_kelas FROM kelas JOIN kelas_aktifs ON kelas.kelas_id = kelas_aktifs.kelas WHERE kelas_aktifs.kelas_aktif_id = kelas_aktif COLLATE utf8mb4_general_ci;
        
            INSERT INTO users(uuid, username, password, created_at, updated_at) 
            VALUES (uuid, nis, pass, NOW(), NOW());
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "insert", "users", NOW());
        
            INSERT INTO model_has_roles(role_id, model_type, model_id)
            VALUES ("6", "App\\Models\\User", uuid);
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "insert", "model_has_roles", NOW());
        
            INSERT INTO user_profiles(user, nama, jenis_kelamin, created_at, updated_at)
            VALUES (uuid, nama, jk, NOW(), NOW());
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "insert", "user_profiles", NOW());
        
            INSERT INTO siswas(nisn, user, nis, tanggal_masuk, kelas_awal, status, created_at, updated_at)
            VALUES(nisn, uuid, nis, tgl_masuk, kelas_awal, "aktif",  NOW(), NOW());
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "insert", "siswas", NOW());
        
            INSERT INTO kontrak_semesters(siswa, kelas, grade, semester_aktif, tahun_ajaran_aktif, status, created_at, updated_at)
            VALUES(nisn, kelas_aktif, grade_kelas, semester, ta, "ongoing", NOW(), NOW());
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "insert", "kontrak_semesters", NOW());
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_tahun_ajaran` (IN `tahun_ajaran` CHAR(9), IN `semester` CHAR(6), IN `start` DATETIME, IN `end` DATETIME, `admin` CHAR(36))   BEGIN
        
            DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
        
            START TRANSACTION;
        
            INSERT INTO tahun_ajarans(tahun_ajaran_id ,tahun_ajaran, semester, tanggal_mulai, tanggal_berakhir, created_at, updated_at)
            VALUES(UUID(), tahun_ajaran, semester, start, end, NOW(), NOW());
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(admin, "insert", "tahun_ajarans", NOW());
        
            COMMIT;
        
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_walikelas` (IN `model_id` CHAR(36), IN `actor` CHAR(36))   BEGIN
        
            DECLARE errno INT;
            DECLARE uuid CHAR(36);
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
            DECLARE EXIT HANDLER for SQLWARNING
            BEGIN
                ROLLBACK;
            END;
        
            START TRANSACTION;
        
            INSERT INTO model_has_roles(role_id, model_type, model_id)
            VALUES ("5", "App\\Models\\User", model_id);
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "insert", "model_has_roles", NOW());
            COMMIT;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `assign_pembina` (IN `admin` CHAR(36), IN `ekskul` CHAR(6), IN `guru` CHAR(16))   BEGIN

            DECLARE uuid_guru CHAR(36);
            DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;

            START TRANSACTION;

            SELECT user INTO uuid_guru FROM gurus 
            WHERE NUPTK = guru COLLATE utf8mb4_general_ci;

            UPDATE ekstrakurikulers SET penanggung_jawab = guru 
            WHERE ekstrakurikuler_id = ekskul COLLATE utf8mb4_general_ci;

            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(admin, "update", "ekstrakurikulers", NOW());

            INSERT INTO model_has_roles(role_id, model_type, model_id)
            VALUES ("7", "App\\Models\\User", uuid_guru);

            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(admin, "insert", "model_has_roles", NOW());
                
            COMMIT;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_ekstrakurikuler` (IN `admin` CHAR(36), IN `ekstrakurikuler` CHAR(5))   BEGIN
    
        DECLARE errno INT;
        DECLARE admin CHAR(36);
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
        END;
    
        SET admin = UUID();
    
        START TRANSACTION;
        DELETE FROM ekstrakurikulers WHERE ekstrakurikuler_id = ekstrakurikuler COLLATE utf8mb4_general_ci;

        INSERT INTO log_activities(actor, action, at, created_at)
        VALUES(admin, "delete", "ekstrakurikulers", NOW());
        
        COMMIT;

        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_ekstrakurikuler_siswa` (IN `ekstrakurikuler_id` CHAR(5), IN `siswa_id` CHAR(10), IN `tahun_ajaran` CHAR(9), IN `admin` CHAR(36))   BEGIN
        
            DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
        
            START TRANSACTION;
            DELETE FROM ekstrakurikuler_siswas WHERE ekstrakurikuler = ekstrakurikuler_id COLLATE utf8mb4_general_ci 
            AND siswa = siswa_id COLLATE utf8mb4_general_ci
            AND tahun_ajaran_aktif = tahun_ajaran COLLATE utf8mb4_general_ci;

            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(admin, "delete", "ekstrakurikuler_siswas", NOW());
            
            COMMIT;

        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_mapel` (IN `mapel` CHAR(5), IN `admin` CHAR(36))   BEGIN
                DECLARE errno INT;
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
                        ROLLBACK;
                    END;

                START TRANSACTION;

                DELETE FROM mapels WHERE mapel_id = mapel COLLATE utf8mb4_general_ci;

                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(admin, "update", "mapels", NOW());

                COMMIT;

            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_mapel_guru` (IN `mapelguru` INT, IN `actor` CHAR(36))   BEGIN
            DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;

            START TRANSACTION;
            DELETE FROM mapel_gurus WHERE mapel_guru_id = mapelguru;

            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "delete", "mapel_gurus", NOW());
            
            COMMIT;

        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_permission` (IN `permission` INT, IN `user` CHAR(36))   BEGIN
        
            DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
        
            START TRANSACTION;
            DELETE FROM permissions WHERE id = permission;
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(user, "delete", "permissions", NOW());
            
            COMMIT;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_prestasi` (IN `prestasi` INT, IN `admin` CHAR(36))   BEGIN
                DECLARE errno INT;
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                BEGIN
                    ROLLBACK;
                END;
            
                START TRANSACTION;
                DELETE FROM prestasis WHERE prestasi_id = prestasi;
            
                 INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(admin, "delete", "prestasis", NOW());
                
                COMMIT;
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_role` (IN `role` INT, IN `user` CHAR(36))   BEGIN
        
            DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
        
            START TRANSACTION;
            DELETE FROM roles WHERE id = role;
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(user, "delete", "roles", NOW());
            
            COMMIT;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_roster` (IN `roster` INT, IN `actor` CHAR(36))   BEGIN
                DECLARE errno INT;
                DECLARE actor CHAR(36);
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                BEGIN
                    ROLLBACK;
                END;

                SET actor = UUID();

                START TRANSACTION;
                DELETE FROM rosters WHERE roster_id = roster;

                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(actor, "delete", "rosters", NOW());
                
                COMMIT;

            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inactive_admin` (IN `admin` CHAR(36), IN `actor` CHAR(36))   BEGIN
                DECLARE errno INT;
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                BEGIN
                    ROLLBACK;
                END;
                START TRANSACTION;

                UPDATE users SET deleted_at = NOW() WHERE uuid = admin COLLATE utf8mb4_general_ci;

                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(actor, "update", "users", NOW());

                UPDATE gurus SET status = "inaktif", updated_at = NOW() WHERE user = admin COLLATE utf8mb4_general_ci;

                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(actor, "update", "gurus", NOW());

                COMMIT;
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inactive_guru` (IN `guru` CHAR(36), IN `actor` CHAR(36))   BEGIN
                DECLARE errno INT;
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                BEGIN
                    ROLLBACK;
                END;
                START TRANSACTION;
                UPDATE gurus SET status = "inaktif", updated_at = NOW()  WHERE user = guru COLLATE utf8mb4_general_ci;
        
                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(actor, "update", "gurus", NOW());
                
                UPDATE users SET deleted_at = NOW() WHERE uuid = guru COLLATE utf8mb4_general_ci; 
                
                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(actor, "update", "users", NOW());
                COMMIT;
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inactive_kelas` (IN `kelas` CHAR(6), IN `actor` CHAR(36))   BEGIN
                UPDATE kelas SET deleted_at = NOW() WHERE kelas_id = kelas COLLATE utf8mb4_general_ci;

                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(actor, "update", "kelas", NOW());
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inactive_mapel` (IN `mapel` CHAR(5), `admin` CHAR(36))   BEGIN

                DECLARE errno INT;
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
                        ROLLBACK;
                    END;
                START TRANSACTION;
                UPDATE mapels SET deleted_at = NOW() WHERE mapel_id = mapel COLLATE utf8mb4_general_ci;

                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(admin, "update", "mapels", NOW());

                UPDATE mapel_gurus SET deleted_at = NOW() WHERE mapel = mapel COLLATE utf8mb4_general_ci;

                COMMIT;

            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inactive_siswa` (IN `siswa` CHAR(36), IN `status` VARCHAR(10), IN `actor` CHAR(36))   BEGIN
                DECLARE errno INT;
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
                        ROLLBACK;
                    END;
                START TRANSACTION;
                UPDATE siswas SET status = status, updated_at = NOW() WHERE user = siswa COLLATE utf8mb4_general_ci;
            
                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(actor, "update", "siswas", NOW());
                
                UPDATE users SET deleted_at = NOW() WHERE uuid = siswa COLLATE utf8mb4_general_ci; 
                COMMIT;
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_admin` (IN `admin` CHAR(36), IN `actor` CHAR(36))   BEGIN
                DECLARE errno INT;
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                BEGIN
                    ROLLBACK;
                END;
                START TRANSACTION;

                UPDATE users SET deleted_at = NULL WHERE uuid = admin COLLATE utf8mb4_general_ci;

                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(actor, "update", "users", NOW());

                COMMIT;
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_guru` (IN `guru` CHAR(36), IN `actor` CHAR(36))   BEGIN
                UPDATE gurus SET status = "aktif", updated_at = NOW()  WHERE user = guru COLLATE utf8mb4_general_ci;
        
                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(actor, "update", "gurus", NOW());
                
                UPDATE users SET deleted_at = NULL WHERE uuid = guru COLLATE utf8mb4_general_ci; 

                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(actor, "update", "users", NOW());
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_kelas` (IN `kelas` CHAR(6), IN `actor` CHAR(36))   BEGIN

            UPDATE kelas SET deleted_at = NULL WHERE kelas_id = kelas COLLATE utf8mb4_general_ci;

            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "update", "kelas", NOW());
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_mapel` (IN `mapel` CHAR(5), IN `admin` CHAR(36))   BEGIN
        
            UPDATE users SET deleted_at = NULL WHERE uuid = admin COLLATE utf8mb4_general_ci;
            UPDATE mapels SET deleted_at = NULL WHERE mapel_id = mapel COLLATE utf8mb4_general_ci;
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(admin, "update", "mapel", NOW());
            
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `unassign_pembina` (IN `ekstrakurikuler` CHAR(6), IN `guru` CHAR(16), IN `admin` CHAR(36))   BEGIN
            DECLARE errno INT;
            DECLARE uuid_guru CHAR(36);
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
            START TRANSACTION;

            SELECT user INTO uuid_guru FROM gurus 
            WHERE NUPTK = guru COLLATE utf8mb4_general_ci;

            UPDATE ekstrakurikulers SET penanggung_jawab = NULL 
            WHERE ekstrakurikuler_id = ekstrakurikuler COLLATE utf8mb4_general_ci;

            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "delete", "ekstrakurikulers", NOW());

            DELETE FROM model_has_roles 
            WHERE model_id = uuid_guru COLLATE utf8mb4_general_ci AND role_id = 7;

            COMMIT;
         END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_admin` (IN `actor` CHAR(36), IN `user` CHAR(36), IN `pass` VARCHAR(255))   BEGIN
        
            DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
            START TRANSACTION;
            
            UPDATE users SET password = pass WHERE uuid = user COLLATE utf8mb4_general_ci; 
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "update", "users", NOW());

            COMMIT;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_ekstrakurikuler` (IN `admin` CHAR(36), IN `ekstrakurikuler` CHAR(5), IN `nama` VARCHAR(30), IN `hari` CHAR(6), IN `waktu_mulai` TIME, IN `waktu_akhir` TIME, IN `tempat` VARCHAR(100), IN `kelas` CHAR(1))   BEGIN
        DECLARE errno INT;
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
        END;

        START TRANSACTION;
        UPDATE ekstrakurikulers SET nama = nama, hari = hari, waktu_mulai = waktu_mulai, waktu_akhir = waktu_akhir, tempat = tempat, kelas = kelas WHERE ekstrakurikuler_id = ekstrakurikuler COLLATE utf8mb4_general_ci;

        INSERT INTO log_activities(actor, action, at, created_at)
        VALUES(admin, "update", "ekstrakurikulers", NOW());

        COMMIT;
                
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_kelas` (IN `kelas` CHAR(6), IN `nama` VARCHAR(255), `actor` CHAR(36))   BEGIN
        START TRANSACTION;
    
        UPDATE kelas SET nama_kelas = nama WHERE kelas_id = kelas COLLATE utf8mb4_general_ci;
    
        INSERT INTO log_activities(actor, action, at, created_at)
        VALUES(actor, "update", "kelas", NOW());
    
        COMMIT;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_kelas_aktif` (IN `kelas` CHAR(36), IN `wali` CHAR(18), `actor` CHAR(36))   BEGIN

        DECLARE old_wali CHAR(18);
        DECLARE errno INT;
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
    
        SELECT wali_kelas INTO old_wali FROM kelas_aktifs WHERE kelas_aktif_id = kelas COLLATE utf8mb4_general_ci;
        START TRANSACTION;

        UPDATE kelas_aktifs SET wali_kelas = wali WHERE kelas_aktif_id = kelas COLLATE utf8mb4_general_ci;
    
        INSERT INTO log_activities(actor, action, at, created_at)
        VALUES(actor, "update", "kelas_aktifs", NOW());
    
        COMMIT;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_nilai` (IN `nilai` INT, IN `sesi` INT, IN `nilai_p` FLOAT, IN `deskripsi_p` TEXT, IN `nilai_k` FLOAT, IN `deskripsi_k` TEXT, IN `user` CHAR(36))   BEGIN
        
            DECLARE start DATETIME;
            DECLARE end DATETIME;
        
            SELECT tanggal_mulai INTO start FROM sesi_penilaians WHERE sesi_id = sesi;
            SELECT tanggal_berakhir INTO end FROM sesi_penilaians WHERE sesi_id = sesi;
        
            IF cek_sesi(start, end) = 1 THEN
                
                UPDATE nilais SET nilai_pengetahuan = nilai_p, deskripsi_pengetahuan = deskripsi_p, nilai_keterampilan = nilai_k, deskripsi_keterampilan = deskripsi_k, status = "pending" WHERE nilai_id = nilai;
        
                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(user, "insert", "nilais", NOW());
            ELSE
                SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT ="Sesi tidak tersedia";
            END IF;
        
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_prestasi` (IN `prestasi` INT, IN `jenis` VARCHAR(12), IN `ket` TEXT, IN `tgl` DATE, IN `admin` CHAR(36))   BEGIN
            DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
        
            START TRANSACTION;
            UPDATE prestasis SET jenis_prestasi = jenis, keterangan = ket, tanggal_prestasi = tgl WHERE prestasi_id = prestasi;
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(admin, "update", "prestasis", NOW());
        
            COMMIT;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_role` (IN `role` INT, IN `nama` VARCHAR(255), IN `user` CHAR(36))   BEGIN
        
            DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
        
            START TRANSACTION;
            UPDATE roles SET name = nama WHERE id = role;
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(user, "insert", "users", NOW());
            
            COMMIT;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_roster` (IN `roster` INT, IN `waktu_mulai` TIME, IN `waktu_akhir` TIME, IN `hari` CHAR(6), IN `actor` CHAR(36))   BEGIN
                DECLARE errno INT;
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                BEGIN
                    ROLLBACK;
                END;

                START TRANSACTION;
                UPDATE rosters SET waktu_mulai = waktu_mulai, waktu_akhir = waktu_akhir, hari = hari WHERE roster_id = roster;

                INSERT INTO log_activities(actor, action, at, created_at)
                VALUES(actor, "update", "rosters", NOW());

                COMMIT;
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_siswa` (IN `oldnis` CHAR(4), IN `newnis` CHAR(4), IN `nama` VARCHAR(255), IN `actor` CHAR(36))   BEGIN
            DECLARE siswa CHAR(36);
            DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
            SELECT user INTO siswa FROM siswas WHERE NIS = oldnis COLLATE utf8mb4_general_ci;
                
            UPDATE siswas SET NIS = newnis WHERE NIS = oldnis COLLATE utf8mb4_general_ci;
                
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "update", "siswas", NOW());

            UPDATE user_profiles SET nama = nama WHERE user = siswa COLLATE utf8mb4_general_ci;
                
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "update", "user_profiles", NOW());
            
            UPDATE users SET username = newnis WHERE uuid = siswa COLLATE utf8mb4_general_ci;
            
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "update", "users", NOW());
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_tahun_ajaran` (IN `tahun_ajaran` CHAR(36), IN `start` DATETIME, IN `end` DATETIME, `admin` CHAR(36))   BEGIN
        
        DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
        
            START TRANSACTION;
        
            UPDATE tahun_ajarans SET tanggal_mulai = start, tanggal_berakhir = end, updated_at = NOW() WHERE tahun_ajaran_id = tahun_ajaran COLLATE utf8mb4_general_ci;
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(admin, "update", "tahun_ajarans", NOW());
        
            COMMIT;
        
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user` (IN `actor` CHAR(36), IN `user` CHAR(36), IN `pass` VARCHAR(255))   BEGIN
        
            DECLARE errno INT;
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
            END;
            START TRANSACTION;
            
            UPDATE users SET password = pass WHERE uuid = user COLLATE utf8mb4_general_ci; 
        
            INSERT INTO log_activities(actor, action, at, created_at)
            VALUES(actor, "update", "users", NOW());
            COMMIT;
        END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `ekstrakurikulersiswa`
-- (See below for the actual view)
--
CREATE TABLE `ekstrakurikulersiswa` (
`nama_ekstrakurikuler` varchar(255)
,`nama_siswa` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `log_tbl_akuns`
--

CREATE TABLE `log_tbl_akuns` (
  `id_akun` int(11) NOT NULL,
  `aksi` enum('Insert','Update','Delete','') NOT NULL,
  `nama_user_lama` varchar(255) DEFAULT NULL,
  `nama_user_baru` varchar(255) DEFAULT NULL,
  `nama_lengkap_lama` varchar(255) DEFAULT NULL,
  `nama_lengkap_baru` varchar(255) DEFAULT NULL,
  `email_lama` varchar(255) DEFAULT NULL,
  `email_baru` varchar(255) DEFAULT NULL,
  `password_lama` varchar(255) DEFAULT NULL,
  `password_baru` varchar(255) DEFAULT NULL,
  `role_lama` enum('Admin','Superadmin','User') DEFAULT NULL,
  `role_baru` enum('Admin','Superadmin','User') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `log_tbl_beritas`
--

CREATE TABLE `log_tbl_beritas` (
  `id` int(10) UNSIGNED NOT NULL,
  `aksi` enum('Insert','Update','Delete','') NOT NULL,
  `id_akun_lama` int(11) DEFAULT NULL,
  `id_akun_baru` int(11) DEFAULT NULL,
  `judul_lama` varchar(255) DEFAULT NULL,
  `judul_baru` varchar(255) DEFAULT NULL,
  `deskripsi_lama` varchar(20) DEFAULT NULL,
  `deskripsi_baru` varchar(29) DEFAULT NULL,
  `foto_filename_lama` varchar(255) DEFAULT NULL,
  `foto_filename_baru` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_tbl_beritas`
--

INSERT INTO `log_tbl_beritas` (`id`, `aksi`, `id_akun_lama`, `id_akun_baru`, `judul_lama`, `judul_baru`, `deskripsi_lama`, `deskripsi_baru`, `foto_filename_lama`, `foto_filename_baru`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Insert', NULL, 2, NULL, 'a', NULL, 'babadadasd', NULL, 'iwFvHbvZjs6lvurpRuudlkuahrXg485uKnOdK7ws.png', '2023-12-21 04:29:34', '2023-12-21 04:29:34', '2023-12-21 04:29:34'),
(2, 'Insert', NULL, 2, NULL, 'test', NULL, 'test', NULL, 'nMPmIUHe2p0CVOdufqVzbRXqjBPtHPBYZVfOKlqu.png', '2023-12-21 04:37:38', '2023-12-21 04:37:38', '2023-12-21 04:37:38'),
(3, 'Delete', 2, NULL, 'a', NULL, 'babadadasd', NULL, 'iwFvHbvZjs6lvurpRuudlkuahrXg485uKnOdK7ws.png', NULL, '2023-12-21 04:41:47', '2023-12-21 04:41:47', '2023-12-21 04:41:47'),
(4, 'Delete', 2, NULL, 'test', NULL, 'test', NULL, 'nMPmIUHe2p0CVOdufqVzbRXqjBPtHPBYZVfOKlqu.png', NULL, '2023-12-21 04:41:49', '2023-12-21 04:41:49', '2023-12-21 04:41:49'),
(5, 'Insert', NULL, 2, NULL, 'test', NULL, 'test', NULL, 'nCqVACEblm0Uxgike3UkCGScawUqmr3vSoTf17bN.png', '2023-12-21 04:42:01', '2023-12-21 04:42:01', '2023-12-21 04:42:01'),
(6, 'Delete', 2, NULL, 'test', NULL, 'test', NULL, 'nCqVACEblm0Uxgike3UkCGScawUqmr3vSoTf17bN.png', NULL, '2023-12-21 04:44:38', '2023-12-21 04:44:38', '2023-12-21 04:44:38'),
(7, 'Insert', NULL, 2, NULL, 'test', NULL, 'test', NULL, '7gYUKh4hM5yOxwGvZsuva1Rk4TJsToigNYGOuHl7.png', '2023-12-21 04:45:00', '2023-12-21 04:45:00', '2023-12-21 04:45:00'),
(8, 'Insert', NULL, 2, NULL, 'a', NULL, 'b', NULL, 'yfFHu5xqDp9tKCArpUkyQy7WIu1z3AvX2zBYNK5Y.png', '2023-12-21 04:56:47', '2023-12-21 04:56:47', '2023-12-21 04:56:47');

-- --------------------------------------------------------

--
-- Table structure for table `log_tbl_ekstrakurikulers`
--

CREATE TABLE `log_tbl_ekstrakurikulers` (
  `id_ekskul` int(10) UNSIGNED NOT NULL,
  `aksi` enum('Insert','Update','Delete') NOT NULL,
  `nama_ekstrakurikuler_lama` varchar(255) DEFAULT NULL,
  `nama_ekstrakurikuler_baru` varchar(255) DEFAULT NULL,
  `ikon_lama` varchar(255) DEFAULT NULL,
  `ikon_baru` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_tbl_ekstrakurikulers`
--

INSERT INTO `log_tbl_ekstrakurikulers` (`id_ekskul`, `aksi`, `nama_ekstrakurikuler_lama`, `nama_ekstrakurikuler_baru`, `ikon_lama`, `ikon_baru`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Insert', NULL, 'Makan', NULL, 'a', '2023-12-21 03:28:50', '2023-12-21 03:28:50', '2023-12-21 03:28:50'),
(2, 'Insert', NULL, 'Makan', NULL, 'aa', '2023-12-21 03:33:41', '2023-12-21 03:33:41', '2023-12-21 03:33:41'),
(3, 'Update', 'Makan', 'Makan', 'aa', 'aaa', '2023-12-21 03:36:24', '2023-12-21 03:36:24', '2023-12-21 03:36:24'),
(4, 'Update', 'Makan', 'Makan', 'aaa', 'aaaasda', '2023-12-21 03:36:30', '2023-12-21 03:36:30', '2023-12-21 03:36:30'),
(5, 'Delete', 'Makan', NULL, 'aaaasda', NULL, '2023-12-21 03:36:35', '2023-12-21 03:36:35', '2023-12-21 03:36:35'),
(6, 'Update', 'Makan', 'Makan', 'a', 'as', '2023-12-21 03:40:31', '2023-12-21 03:40:31', '2023-12-21 03:40:31'),
(7, 'Delete', 'Makan', NULL, 'as', NULL, '2023-12-21 03:40:45', '2023-12-21 03:40:45', '2023-12-21 03:40:45');

-- --------------------------------------------------------

--
-- Table structure for table `log_tbl_ekstrakurikuler_siswas`
--

CREATE TABLE `log_tbl_ekstrakurikuler_siswas` (
  `id` int(11) NOT NULL,
  `aksi` enum('Insert','Update','Delete') NOT NULL,
  `id_ekskul_baru` int(11) DEFAULT NULL,
  `id_ekskul_lama` int(11) DEFAULT NULL,
  `nisn_siswa_baru` varchar(10) DEFAULT NULL,
  `nisn_siswa_lama` varchar(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_tbl_ekstrakurikuler_siswas`
--

INSERT INTO `log_tbl_ekstrakurikuler_siswas` (`id`, `aksi`, `id_ekskul_baru`, `id_ekskul_lama`, `nisn_siswa_baru`, `nisn_siswa_lama`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Delete', NULL, 2, NULL, '0121427032', NULL, NULL, '2023-11-28 17:14:37'),
(2, 'Delete', NULL, 3, NULL, '0125024029', NULL, NULL, '2023-11-28 17:14:44');

-- --------------------------------------------------------

--
-- Table structure for table `log_tbl_gurus`
--

CREATE TABLE `log_tbl_gurus` (
  `id` int(10) UNSIGNED NOT NULL,
  `aksi` enum('Insert','Update','Delete','') NOT NULL,
  `nama_guru_lama` varchar(255) DEFAULT NULL,
  `nama_guru_baru` varchar(255) DEFAULT NULL,
  `ket_guru_lama` enum('Non-PNS','GTT Komite') DEFAULT NULL,
  `ket_guru_baru` enum('Non-PNS','GTT Komite') DEFAULT NULL,
  `status_guru_lama` enum('Aktif','Tidak Aktif','Mengundurkan Diri') NOT NULL,
  `status_guru_baru` enum('Aktif','Tidak Aktif','Mengundurkan Diri') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_tbl_gurus`
--

INSERT INTO `log_tbl_gurus` (`id`, `aksi`, `nama_guru_lama`, `nama_guru_baru`, `ket_guru_lama`, `ket_guru_baru`, `status_guru_lama`, `status_guru_baru`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Update', 'Linda Siti Zulaikha, S.Pd', 'Linda Siti Zulaikha, S.Pd', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(2, 'Update', 'Siti Warohmah', 'Siti Warohmah', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(3, 'Update', 'Andi Putra Batubara', 'Andi Putra Batubara', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(4, 'Update', 'Ali Rahman, S.Pd.I', 'Ali Rahman, S.Pd.I', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(5, 'Update', 'Chairul Azmi Lubis, S.Pd', 'Chairul Azmi Lubis, S.Pd', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(6, 'Update', 'Riri Andrian, S.Pd', 'Riri Andrian, S.Pd', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(7, 'Update', 'Sri Wedari, S.Ag', 'Sri Wedari, S.Ag', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(8, 'Update', 'Nurlia Ayuni, S.Pd', 'Nurlia Ayuni, S.Pd', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(9, 'Update', 'Mariani, S.Pd.I', 'Mariani, S.Pd.I', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(10, 'Update', 'Nahfazul Fauziah Harahap, S.Pd', 'Nahfazul Fauziah Harahap, S.Pd', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(11, 'Update', 'Salmah, S.Ag', 'Salmah, S.Ag', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(12, 'Update', 'Susilawati, S.Ag', 'Susilawati, S.Ag', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(13, 'Update', 'Laily Ramadhani, S.Pd, M.Ak', 'Laily Ramadhani, S.Pd, M.Ak', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(14, 'Update', 'Nuranisa, S.Pd.I', 'Nuranisa, S.Pd.I', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(15, 'Update', 'Rudi Ahmad, S.Pd.I', 'Rudi Ahmad, S.Pd.I', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(16, 'Update', 'Seri Wahyuni, S.Pd.I', 'Seri Wahyuni, S.Pd.I', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(17, 'Update', 'Masitah, S.Pd.I', 'Masitah, S.Pd.I', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(18, 'Update', 'Qatrunnada, S.Pd.I', 'Qatrunnada, S.Pd.I', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(19, 'Update', 'Maimunah. Bb, S.Sos', 'Maimunah. Bb, S.Sos', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(20, 'Update', 'Nuraini, SE', 'Nuraini, SE', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(21, 'Update', 'Alvy Hayati Nur', 'Alvy Hayati Nur', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-02 12:29:28', '2023-12-02 12:29:28', '2023-12-02 12:29:28'),
(22, 'Insert', NULL, '', NULL, '', 'Aktif', 'Aktif', '2023-12-08 19:54:45', '2023-12-08 19:54:45', '2023-12-08 19:54:45'),
(23, 'Delete', '', NULL, '', NULL, 'Aktif', 'Aktif', '2023-12-08 19:55:52', '2023-12-08 19:55:52', '2023-12-08 19:55:52'),
(24, 'Insert', NULL, 'NISA', NULL, '', 'Aktif', 'Aktif', '2023-12-21 01:19:10', '2023-12-21 01:19:10', '2023-12-21 01:19:10'),
(25, 'Update', 'NISA', 'NISA SABYAN', '', '', 'Aktif', 'Aktif', '2023-12-21 01:19:50', '2023-12-21 01:19:50', '2023-12-21 01:19:50'),
(26, 'Update', 'NISA SABYAN', 'NISA SABYAN', '', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-21 01:20:33', '2023-12-21 01:20:33', '2023-12-21 01:20:33'),
(27, 'Update', 'NISA SABYAN', 'NISA SABYAN', 'Non-PNS', 'GTT Komite', 'Aktif', 'Aktif', '2023-12-21 01:20:38', '2023-12-21 01:20:38', '2023-12-21 01:20:38'),
(28, 'Update', 'NISA SABYAN', 'NISA SABYAN', 'GTT Komite', 'GTT Komite', '', 'Aktif', '2023-12-21 01:21:23', '2023-12-21 01:21:23', '2023-12-21 01:21:23'),
(29, 'Delete', 'NISA SABYAN', NULL, 'GTT Komite', NULL, '', 'Aktif', '2023-12-21 01:23:23', '2023-12-21 01:23:23', '2023-12-21 01:23:23'),
(30, 'Insert', NULL, 'NISA', NULL, '', 'Aktif', 'Aktif', '2023-12-21 01:24:21', '2023-12-21 01:24:21', '2023-12-21 01:24:21'),
(31, 'Delete', 'NISA', NULL, '', NULL, 'Aktif', 'Aktif', '2023-12-21 01:24:54', '2023-12-21 01:24:54', '2023-12-21 01:24:54'),
(32, 'Insert', NULL, 'NISA SABYAN', NULL, '', 'Aktif', 'Aktif', '2023-12-21 01:25:47', '2023-12-21 01:25:47', '2023-12-21 01:25:47'),
(33, 'Delete', 'NISA SABYAN', NULL, '', NULL, 'Aktif', 'Aktif', '2023-12-21 01:25:52', '2023-12-21 01:25:52', '2023-12-21 01:25:52'),
(34, 'Insert', NULL, 'NISA SABYAN', NULL, '', 'Aktif', 'Aktif', '2023-12-21 01:26:58', '2023-12-21 01:26:58', '2023-12-21 01:26:58'),
(35, 'Delete', 'NISA SABYAN', NULL, '', NULL, 'Aktif', 'Aktif', '2023-12-21 01:27:01', '2023-12-21 01:27:01', '2023-12-21 01:27:01'),
(36, 'Insert', NULL, 'NISA SABYAN', NULL, '', 'Aktif', 'Aktif', '2023-12-21 01:27:33', '2023-12-21 01:27:33', '2023-12-21 01:27:33'),
(37, 'Delete', 'NISA SABYAN', NULL, '', NULL, 'Aktif', 'Aktif', '2023-12-21 01:27:36', '2023-12-21 01:27:36', '2023-12-21 01:27:36');

-- --------------------------------------------------------

--
-- Table structure for table `log_tbl_kelas`
--

CREATE TABLE `log_tbl_kelas` (
  `id` int(10) UNSIGNED NOT NULL,
  `aksi` enum('Insert','Update','Delete','') NOT NULL,
  `nama_lama` varchar(255) DEFAULT NULL,
  `nama_baru` varchar(255) DEFAULT NULL,
  `wali_kelas_lama` int(11) DEFAULT NULL,
  `wali_kelas_baru` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_tbl_kelas`
--

INSERT INTO `log_tbl_kelas` (`id`, `aksi`, `nama_lama`, `nama_baru`, `wali_kelas_lama`, `wali_kelas_baru`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Insert', NULL, '', NULL, 20, '2023-12-08 19:01:52', '2023-12-08 19:01:52', '2023-12-08 19:01:52'),
(2, 'Update', '', 'VI-C', 20, 20, '2023-12-08 19:03:19', '2023-12-08 19:03:19', '2023-12-08 19:03:19'),
(3, 'Insert', NULL, 'VII-A', NULL, 1, '2023-12-08 19:03:39', '2023-12-08 19:03:39', '2023-12-08 19:03:39'),
(4, 'Delete', 'VII-A', NULL, 1, NULL, '2023-12-08 19:04:29', '2023-12-08 19:04:29', '2023-12-08 19:04:29'),
(5, 'Delete', 'VI-C', NULL, 20, NULL, '2023-12-08 19:04:35', '2023-12-08 19:04:35', '2023-12-08 19:04:35'),
(6, 'Insert', NULL, 'test', NULL, 1, '2023-12-21 00:54:44', '2023-12-21 00:54:44', '2023-12-21 00:54:44'),
(7, 'Update', 'test', 'tests', 1, 1, '2023-12-21 00:54:59', '2023-12-21 00:54:59', '2023-12-21 00:54:59'),
(8, 'Update', 'tests', 'tests', 1, 2, '2023-12-21 00:55:05', '2023-12-21 00:55:05', '2023-12-21 00:55:05'),
(9, 'Delete', 'tests', NULL, 2, NULL, '2023-12-21 00:55:09', '2023-12-21 00:55:09', '2023-12-21 00:55:09'),
(10, 'Insert', NULL, 'Testt', NULL, 1, '2023-12-21 01:15:35', '2023-12-21 01:15:35', '2023-12-21 01:15:35'),
(11, 'Delete', 'Testt', NULL, 1, NULL, '2023-12-21 01:18:40', '2023-12-21 01:18:40', '2023-12-21 01:18:40');

-- --------------------------------------------------------

--
-- Table structure for table `log_tbl_mapel_gurus`
--

CREATE TABLE `log_tbl_mapel_gurus` (
  `id` int(11) NOT NULL,
  `aksi` enum('Insert','Update','Delete') NOT NULL,
  `id_guru_lama` int(11) NOT NULL,
  `id_guru_baru` int(11) NOT NULL,
  `id_mapel_lama` int(11) NOT NULL,
  `id_mapel_baru` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_tbl_mapel_gurus`
--

INSERT INTO `log_tbl_mapel_gurus` (`id`, `aksi`, `id_guru_lama`, `id_guru_baru`, `id_mapel_lama`, `id_mapel_baru`, `created_at`, `deleted_at`, `updated_at`) VALUES
(4, 'Insert', 0, 1, 0, 1, '2023-11-27 15:39:02', NULL, NULL),
(5, 'Insert', 0, 2, 0, 13, '2023-11-27 15:39:02', NULL, NULL),
(6, 'Insert', 0, 3, 0, 4, '2023-11-27 15:39:02', NULL, NULL),
(7, 'Insert', 0, 4, 0, 5, '2023-11-27 15:39:02', NULL, NULL),
(8, 'Insert', 0, 5, 0, 5, '2023-11-27 15:39:02', NULL, NULL),
(9, 'Insert', 0, 6, 0, 4, '2023-11-27 15:39:02', NULL, NULL),
(10, 'Insert', 0, 7, 0, 2, '2023-11-27 15:39:02', NULL, NULL),
(11, 'Insert', 0, 8, 0, 3, '2023-11-27 15:39:02', NULL, NULL),
(12, 'Insert', 0, 9, 0, 2, '2023-11-27 15:39:02', NULL, NULL),
(13, 'Insert', 0, 10, 0, 2, '2023-11-27 15:39:02', NULL, NULL),
(14, 'Insert', 0, 11, 0, 3, '2023-11-27 15:39:02', NULL, NULL),
(15, 'Insert', 0, 12, 0, 2, '2023-11-27 15:39:02', NULL, NULL),
(16, 'Insert', 0, 13, 0, 2, '2023-11-27 15:39:02', NULL, NULL),
(17, 'Insert', 0, 14, 0, 12, '2023-11-27 15:39:02', NULL, NULL),
(18, 'Insert', 0, 15, 0, 2, '2023-11-27 15:39:02', NULL, NULL),
(19, 'Insert', 0, 16, 0, 11, '2023-11-27 15:39:02', NULL, NULL),
(20, 'Insert', 0, 17, 0, 2, '2023-11-27 15:39:02', NULL, NULL),
(21, 'Insert', 0, 18, 0, 3, '2023-11-27 15:39:02', NULL, NULL),
(22, 'Insert', 0, 19, 0, 12, '2023-11-27 15:39:02', NULL, NULL),
(23, 'Insert', 0, 20, 0, 3, '2023-11-27 15:39:02', NULL, NULL),
(24, 'Insert', 0, 21, 0, 2, '2023-11-27 15:39:02', NULL, NULL),
(25, 'Insert', 0, 1, 0, 1, '2023-11-27 15:45:27', NULL, NULL),
(26, 'Insert', 0, 2, 0, 13, '2023-11-27 15:45:27', NULL, NULL),
(27, 'Insert', 0, 3, 0, 4, '2023-11-27 15:45:27', NULL, NULL),
(28, 'Insert', 0, 4, 0, 5, '2023-11-27 15:45:27', NULL, NULL),
(29, 'Insert', 0, 5, 0, 5, '2023-11-27 15:45:27', NULL, NULL),
(30, 'Insert', 0, 6, 0, 4, '2023-11-27 15:45:27', NULL, NULL),
(31, 'Insert', 0, 7, 0, 2, '2023-11-27 15:45:27', NULL, NULL),
(32, 'Insert', 0, 8, 0, 3, '2023-11-27 15:45:27', NULL, NULL),
(33, 'Insert', 0, 9, 0, 2, '2023-11-27 15:45:27', NULL, NULL),
(34, 'Insert', 0, 10, 0, 2, '2023-11-27 15:45:27', NULL, NULL),
(35, 'Insert', 0, 11, 0, 3, '2023-11-27 15:45:27', NULL, NULL),
(36, 'Insert', 0, 12, 0, 2, '2023-11-27 15:45:27', NULL, NULL),
(37, 'Insert', 0, 13, 0, 2, '2023-11-27 15:45:27', NULL, NULL),
(38, 'Insert', 0, 14, 0, 12, '2023-11-27 15:45:27', NULL, NULL),
(39, 'Insert', 0, 15, 0, 2, '2023-11-27 15:45:27', NULL, NULL),
(40, 'Insert', 0, 16, 0, 11, '2023-11-27 15:45:27', NULL, NULL),
(41, 'Insert', 0, 17, 0, 2, '2023-11-27 15:45:27', NULL, NULL),
(42, 'Insert', 0, 18, 0, 3, '2023-11-27 15:45:27', NULL, NULL),
(43, 'Insert', 0, 19, 0, 12, '2023-11-27 15:45:27', NULL, NULL),
(44, 'Insert', 0, 20, 0, 3, '2023-11-27 15:45:27', NULL, NULL),
(45, 'Insert', 0, 21, 0, 2, '2023-11-27 15:45:27', NULL, NULL),
(46, 'Delete', 1, 0, 1, 0, NULL, '2023-11-27 15:46:39', NULL),
(47, 'Delete', 2, 0, 13, 0, NULL, '2023-11-27 15:46:39', NULL),
(48, 'Delete', 3, 0, 4, 0, NULL, '2023-11-27 15:46:39', NULL),
(49, 'Delete', 4, 0, 5, 0, NULL, '2023-11-27 15:46:39', NULL),
(50, 'Delete', 5, 0, 5, 0, NULL, '2023-11-27 15:46:39', NULL),
(51, 'Delete', 6, 0, 4, 0, NULL, '2023-11-27 15:46:39', NULL),
(52, 'Delete', 7, 0, 2, 0, NULL, '2023-11-27 15:46:39', NULL),
(53, 'Delete', 8, 0, 3, 0, NULL, '2023-11-27 15:46:39', NULL),
(54, 'Delete', 9, 0, 2, 0, NULL, '2023-11-27 15:46:39', NULL),
(55, 'Delete', 10, 0, 2, 0, NULL, '2023-11-27 15:46:39', NULL),
(56, 'Delete', 11, 0, 3, 0, NULL, '2023-11-27 15:46:39', NULL),
(57, 'Delete', 12, 0, 2, 0, NULL, '2023-11-27 15:46:39', NULL),
(58, 'Delete', 13, 0, 2, 0, NULL, '2023-11-27 15:46:39', NULL),
(59, 'Delete', 14, 0, 12, 0, NULL, '2023-11-27 15:46:39', NULL),
(60, 'Delete', 15, 0, 2, 0, NULL, '2023-11-27 15:46:39', NULL),
(61, 'Delete', 16, 0, 11, 0, NULL, '2023-11-27 15:46:39', NULL),
(62, 'Delete', 17, 0, 2, 0, NULL, '2023-11-27 15:46:39', NULL),
(63, 'Delete', 18, 0, 3, 0, NULL, '2023-11-27 15:46:39', NULL),
(64, 'Delete', 19, 0, 12, 0, NULL, '2023-11-27 15:46:39', NULL),
(65, 'Delete', 20, 0, 3, 0, NULL, '2023-11-27 15:46:39', NULL),
(66, 'Delete', 21, 0, 2, 0, NULL, '2023-11-27 15:46:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `log_tbl_nilais`
--

CREATE TABLE `log_tbl_nilais` (
  `id` int(11) NOT NULL,
  `aksi` enum('Insert','Update','Delete') NOT NULL,
  `nisn_siswa_lama` varchar(10) DEFAULT NULL,
  `nisn_siswa_baru` varchar(10) DEFAULT NULL,
  `jenis_nilai_lama` enum('UH-1','UH-2','UTS','UH-3','UH-4','UAS') DEFAULT NULL,
  `jenis_nilai_baru` enum('UH-1','UH-2','UTS','UH-3','UH-4','UAS') DEFAULT NULL,
  `id_mapel_lama` int(11) DEFAULT NULL,
  `id_mapel_baru` int(11) DEFAULT NULL,
  `id_guru_lama` int(11) DEFAULT NULL,
  `id_guru_baru` int(11) DEFAULT NULL,
  `nilai_lama` int(11) DEFAULT NULL,
  `nilai_baru` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_tbl_nilais`
--

INSERT INTO `log_tbl_nilais` (`id`, `aksi`, `nisn_siswa_lama`, `nisn_siswa_baru`, `jenis_nilai_lama`, `jenis_nilai_baru`, `id_mapel_lama`, `id_mapel_baru`, `id_guru_lama`, `id_guru_baru`, `nilai_lama`, `nilai_baru`, `created_at`, `deleted_at`, `updated_at`) VALUES
(0, 'Insert', NULL, '999999', NULL, '', NULL, 2, NULL, 21, NULL, 15, '2023-12-19 16:29:39', NULL, NULL),
(0, 'Insert', '999999', '999999', '', '', 2, 2, 21, 21, 15, 15, NULL, NULL, '2023-12-19 16:30:55'),
(0, 'Insert', '999999', '999999', '', '', 2, 2, 21, 21, 15, 15, NULL, NULL, '2023-12-19 16:49:34');

-- --------------------------------------------------------

--
-- Table structure for table `log_tbl_pegawais`
--

CREATE TABLE `log_tbl_pegawais` (
  `id` int(10) UNSIGNED NOT NULL,
  `aksi` enum('Insert','Update','Delete','') NOT NULL,
  `nama_pegawai_lama` varchar(255) DEFAULT NULL,
  `nama_pegawai_baru` varchar(255) DEFAULT NULL,
  `jk_pegawai_lama` varchar(20) DEFAULT NULL,
  `jk_pegawai_baru` varchar(20) DEFAULT NULL,
  `ket_pegawai_lama` varchar(255) DEFAULT NULL,
  `ket_pegawai_baru` varchar(255) DEFAULT NULL,
  `status_pegawai_baru` enum('Aktif','Tidak Aktif','Mengundurkan Diri') NOT NULL,
  `status_pegawai_lama` enum('Aktif','Tidak Aktif','Mengundurkan Diri') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_tbl_pegawais`
--

INSERT INTO `log_tbl_pegawais` (`id`, `aksi`, `nama_pegawai_lama`, `nama_pegawai_baru`, `jk_pegawai_lama`, `jk_pegawai_baru`, `ket_pegawai_lama`, `ket_pegawai_baru`, `status_pegawai_baru`, `status_pegawai_lama`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Update', 'Elfi Nurmansyah', 'Elfi Nurmansyah', 'L', 'P', 'Penjaga Sekolah', 'Penjaga Sekolah', 'Aktif', 'Aktif', '2023-12-21 03:06:20', '2023-12-21 03:06:20', '2023-12-21 03:06:20'),
(2, 'Update', 'Linda Siti Zulaikha', 'Linda Siti Zulaikha', 'P', 'P', 'Kepala Sekolah', 'Kepala Sekolah', '', 'Aktif', '2023-12-21 03:06:34', '2023-12-21 03:06:34', '2023-12-21 03:06:34'),
(3, 'Update', 'Mahmun Saputra', 'Mahmun Saputra', 'P', 'L', 'Petugas Keamanan/Kebersihan', 'Petugas Keamanan/Kebersihan', 'Aktif', 'Aktif', '2023-12-21 03:20:08', '2023-12-21 03:20:08', '2023-12-21 03:20:08'),
(4, 'Update', 'Elfi Nurmansyah', 'Elfi Nurmansyah', 'P', 'L', 'Penjaga Sekolah', 'Penjaga Sekolah', 'Aktif', 'Aktif', '2023-12-21 05:13:52', '2023-12-21 05:13:52', '2023-12-21 05:13:52'),
(5, 'Insert', NULL, 'NewJeans', NULL, 'P', NULL, 'Idol GROUP', 'Aktif', 'Aktif', '2023-12-21 05:13:59', '2023-12-21 05:13:59', '2023-12-21 05:13:59'),
(6, 'Delete', 'NewJeans', NULL, 'P', NULL, 'Idol GROUP', NULL, 'Aktif', 'Aktif', '2023-12-21 05:18:56', '2023-12-21 05:18:56', '2023-12-21 05:18:56'),
(7, 'Insert', NULL, 'Nuranisa Ainis', NULL, 'P', NULL, 'Idol GROUP', 'Aktif', 'Aktif', '2023-12-21 05:19:25', '2023-12-21 05:19:25', '2023-12-21 05:19:25'),
(8, 'Delete', 'Nuranisa Ainis', NULL, 'P', NULL, 'Idol GROUP', NULL, 'Aktif', 'Aktif', '2023-12-21 05:19:29', '2023-12-21 05:19:29', '2023-12-21 05:19:29');

-- --------------------------------------------------------

--
-- Table structure for table `log_tbl_prestasis`
--

CREATE TABLE `log_tbl_prestasis` (
  `id` int(10) UNSIGNED NOT NULL,
  `aksi` enum('Insert','Update','Delete','') NOT NULL,
  `nama_prestasi_lama` varchar(255) DEFAULT NULL,
  `nama_prestasi_baru` varchar(255) CHARACTER SET utf32 DEFAULT NULL,
  `deskripsi_lama` text,
  `deskripsi_baru` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_tbl_prestasis`
--

INSERT INTO `log_tbl_prestasis` (`id`, `aksi`, `nama_prestasi_lama`, `nama_prestasi_baru`, `deskripsi_lama`, `deskripsi_baru`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Insert', NULL, 'test', NULL, 'test', '2023-12-18 13:58:49', '2023-12-18 13:58:49', '2023-12-18 13:58:49'),
(2, 'Update', 'test', 'test', 'test', 'testod', '2023-12-18 14:05:25', '2023-12-18 14:05:25', '2023-12-18 14:05:25'),
(3, 'Insert', NULL, 'test', NULL, 'test', '2023-12-21 03:21:05', '2023-12-21 03:21:05', '2023-12-21 03:21:05'),
(4, 'Update', 'test', 'testas', 'test', 'testas', '2023-12-21 03:21:12', '2023-12-21 03:21:12', '2023-12-21 03:21:12'),
(5, 'Delete', 'testas', NULL, 'testas', NULL, '2023-12-21 03:23:28', '2023-12-21 03:23:28', '2023-12-21 03:23:28');

-- --------------------------------------------------------

--
-- Table structure for table `log_tbl_rosters`
--

CREATE TABLE `log_tbl_rosters` (
  `id` int(11) NOT NULL,
  `aksi` enum('Insert','Update','Delete') NOT NULL,
  `mapel_guru_lama` int(11) DEFAULT NULL,
  `mapel_guru_baru` int(11) DEFAULT NULL,
  `kelas_lama` int(11) DEFAULT NULL,
  `kelas_baru` int(11) DEFAULT NULL,
  `tahun_ajaran_aktif_lama` char(9) DEFAULT NULL,
  `tahun_ajaran_aktif_baru` char(9) DEFAULT NULL,
  `semester_aktif_lama` enum('Ganjil','Genap') DEFAULT NULL,
  `semester_aktif_baru` enum('Ganjil','Genap') DEFAULT NULL,
  `waktu_mulai_lama` time DEFAULT NULL,
  `waktu_mulai_baru` time DEFAULT NULL,
  `waktu_akhir_lama` time DEFAULT NULL,
  `waktu_akhir_baru` time DEFAULT NULL,
  `hari_lama` enum('Senin','Selasa','Rabu','Kamis','Jumat','Sabtu') DEFAULT NULL,
  `hari_baru` enum('Senin','Selasa','Rabu','Kamis','Jumat','Sabtu') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_tbl_rosters`
--

INSERT INTO `log_tbl_rosters` (`id`, `aksi`, `mapel_guru_lama`, `mapel_guru_baru`, `kelas_lama`, `kelas_baru`, `tahun_ajaran_aktif_lama`, `tahun_ajaran_aktif_baru`, `semester_aktif_lama`, `semester_aktif_baru`, `waktu_mulai_lama`, `waktu_mulai_baru`, `waktu_akhir_lama`, `waktu_akhir_baru`, `hari_lama`, `hari_baru`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '10:30:00', NULL, '11:00:00', NULL, 'Senin', '2023-11-29 05:55:53', NULL, NULL),
(2, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:00:00', NULL, '11:30:00', NULL, 'Senin', '2023-11-29 05:55:53', NULL, NULL),
(3, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2202', NULL, 'Genap', NULL, '11:30:00', NULL, '12:00:00', NULL, 'Senin', '2023-11-29 05:55:53', NULL, NULL),
(4, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:15:00', NULL, '12:45:00', NULL, 'Senin', '2023-11-29 05:55:53', NULL, NULL),
(5, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:45:00', NULL, '13:15:00', NULL, 'Senin', '2023-11-29 05:55:53', NULL, NULL),
(6, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '10:30:00', NULL, '11:00:00', NULL, 'Selasa', '2023-11-29 05:55:53', NULL, NULL),
(7, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:00:00', NULL, '11:30:00', NULL, 'Selasa', '2023-11-29 05:55:53', NULL, NULL),
(8, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:30:00', NULL, '12:00:00', NULL, 'Selasa', '2023-11-29 05:55:53', NULL, NULL),
(9, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:15:00', NULL, '12:45:00', NULL, 'Selasa', '2023-11-29 05:55:53', NULL, NULL),
(10, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:45:00', NULL, '13:15:00', NULL, 'Selasa', '2023-11-29 05:55:53', NULL, NULL),
(11, 'Insert', NULL, 49, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '10:30:00', NULL, '11:00:00', NULL, 'Rabu', '2023-11-29 05:55:53', NULL, NULL),
(12, 'Insert', NULL, 49, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:00:00', NULL, '11:30:00', NULL, 'Rabu', '2023-11-29 05:55:53', NULL, NULL),
(13, 'Insert', NULL, 49, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:30:00', NULL, '12:00:00', NULL, 'Rabu', '2023-11-29 05:55:53', NULL, NULL),
(14, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:15:00', NULL, '12:45:00', NULL, 'Rabu', '2023-11-29 05:55:53', NULL, NULL),
(15, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:45:00', NULL, '13:15:00', NULL, 'Rabu', '2023-11-29 05:55:53', NULL, NULL),
(16, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '10:30:00', NULL, '11:00:00', NULL, 'Kamis', '2023-11-29 05:55:53', NULL, NULL),
(17, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:00:00', NULL, '11:30:00', NULL, 'Kamis', '2023-11-29 05:55:53', NULL, NULL),
(18, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:30:00', NULL, '12:00:00', NULL, 'Kamis', '2023-11-29 05:55:53', NULL, NULL),
(19, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:15:00', NULL, '12:45:00', NULL, 'Kamis', '2023-11-29 05:55:53', NULL, NULL),
(20, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:45:00', NULL, '13:15:00', NULL, 'Kamis', '2023-11-29 05:55:53', NULL, NULL),
(21, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '10:30:00', NULL, '11:00:00', NULL, 'Jumat', '2023-11-29 05:55:53', NULL, NULL),
(22, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:00:00', NULL, '11:30:00', NULL, 'Jumat', '2023-11-29 05:55:53', NULL, NULL),
(23, 'Insert', NULL, 52, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:30:00', NULL, '12:00:00', NULL, 'Jumat', '2023-11-29 05:55:53', NULL, NULL),
(24, 'Insert', NULL, 52, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:00:00', NULL, '12:15:00', NULL, '', '2023-11-29 05:55:53', NULL, NULL),
(25, 'Insert', NULL, 51, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '10:30:00', NULL, '11:00:00', NULL, 'Sabtu', '2023-11-29 05:55:53', NULL, NULL),
(26, 'Insert', NULL, 51, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:00:00', NULL, '11:30:00', NULL, 'Sabtu', '2023-11-29 05:55:53', NULL, NULL),
(27, 'Insert', NULL, 8, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:30:00', NULL, '12:00:00', NULL, 'Sabtu', '2023-11-29 05:55:53', NULL, NULL),
(28, 'Insert', NULL, 8, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:00:00', NULL, '12:15:00', NULL, 'Sabtu', '2023-11-29 05:55:53', NULL, NULL),
(29, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '10:30:00', NULL, '11:00:00', NULL, 'Senin', '2023-11-29 06:02:37', NULL, NULL),
(30, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:00:00', NULL, '11:30:00', NULL, 'Senin', '2023-11-29 06:02:37', NULL, NULL),
(31, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:30:00', NULL, '12:00:00', NULL, 'Senin', '2023-11-29 06:02:37', NULL, NULL),
(32, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:15:00', NULL, '12:45:00', NULL, 'Senin', '2023-11-29 06:02:37', NULL, NULL),
(33, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:45:00', NULL, '13:15:00', NULL, 'Senin', '2023-11-29 06:02:37', NULL, NULL),
(34, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '10:30:00', NULL, '11:00:00', NULL, 'Selasa', '2023-11-29 06:02:37', NULL, NULL),
(35, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:00:00', NULL, '11:30:00', NULL, 'Selasa', '2023-11-29 06:02:37', NULL, NULL),
(36, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:30:00', NULL, '12:00:00', NULL, 'Selasa', '2023-11-29 06:02:37', NULL, NULL),
(37, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:15:00', NULL, '12:45:00', NULL, 'Selasa', '2023-11-29 06:02:37', NULL, NULL),
(38, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:45:00', NULL, '13:15:00', NULL, 'Selasa', '2023-11-29 06:02:37', NULL, NULL),
(39, 'Insert', NULL, 49, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '10:30:00', NULL, '11:00:00', NULL, 'Rabu', '2023-11-29 06:02:37', NULL, NULL),
(40, 'Insert', NULL, 49, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:00:00', NULL, '11:30:00', NULL, 'Rabu', '2023-11-29 06:02:37', NULL, NULL),
(41, 'Insert', NULL, 49, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:30:00', NULL, '12:00:00', NULL, 'Rabu', '2023-11-29 06:02:37', NULL, NULL),
(42, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:15:00', NULL, '12:45:00', NULL, 'Rabu', '2023-11-29 06:02:37', NULL, NULL),
(43, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:45:00', NULL, '13:15:00', NULL, 'Rabu', '2023-11-29 06:02:37', NULL, NULL),
(44, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '10:30:00', NULL, '11:00:00', NULL, 'Kamis', '2023-11-29 06:02:37', NULL, NULL),
(45, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:00:00', NULL, '11:30:00', NULL, 'Kamis', '2023-11-29 06:02:37', NULL, NULL),
(46, 'Insert', NULL, 58, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:30:00', NULL, '12:00:00', NULL, 'Kamis', '2023-11-29 06:02:37', NULL, NULL),
(47, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:15:00', NULL, '12:45:00', NULL, 'Kamis', '2023-11-29 06:02:37', NULL, NULL),
(48, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:45:00', NULL, '13:15:00', NULL, 'Kamis', '2023-11-29 06:02:37', NULL, NULL),
(49, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '10:30:00', NULL, '11:00:00', NULL, 'Jumat', '2023-11-29 06:02:37', NULL, NULL),
(50, 'Insert', NULL, 7, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:00:00', NULL, '11:30:00', NULL, 'Jumat', '2023-11-29 06:02:37', NULL, NULL),
(51, 'Insert', NULL, 52, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:30:00', NULL, '12:00:00', NULL, 'Jumat', '2023-11-29 06:02:37', NULL, NULL),
(52, 'Insert', NULL, 52, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:00:00', NULL, '12:15:00', NULL, 'Jumat', '2023-11-29 06:02:37', NULL, NULL),
(53, 'Insert', NULL, 51, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '10:30:00', NULL, '11:00:00', NULL, 'Sabtu', '2023-11-29 06:02:37', NULL, NULL),
(54, 'Insert', NULL, 51, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:00:00', NULL, '11:30:00', NULL, 'Sabtu', '2023-11-29 06:02:37', NULL, NULL),
(55, 'Insert', NULL, 8, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '11:30:00', NULL, '12:00:00', NULL, 'Sabtu', '2023-11-29 06:02:37', NULL, NULL),
(56, 'Insert', NULL, 8, NULL, 4, NULL, '2023/2024', NULL, 'Genap', NULL, '12:00:00', NULL, '12:15:00', NULL, 'Sabtu', '2023-11-29 06:02:37', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `log_tbl_siswas`
--

CREATE TABLE `log_tbl_siswas` (
  `id` int(10) UNSIGNED NOT NULL,
  `aksi` enum('Insert','Update','Delete','') NOT NULL,
  `nipd_lama` int(11) DEFAULT NULL,
  `nipd_baru` int(11) DEFAULT NULL,
  `nisn_lama` varchar(10) DEFAULT NULL,
  `nisn_baru` varchar(10) DEFAULT NULL,
  `nama_siswa_lama` varchar(255) DEFAULT NULL,
  `nama_siswa_baru` varchar(255) DEFAULT NULL,
  `jk_siswa_lama` enum('L','P','','') DEFAULT NULL,
  `jk_siswa_baru` enum('L','P','','') DEFAULT NULL,
  `agama_siswa_lama` enum('Islam') DEFAULT NULL,
  `agama_siswa_baru` enum('Islam') DEFAULT NULL,
  `tempat_lahir_lama` varchar(255) DEFAULT NULL,
  `tempat_lahir_baru` varchar(255) DEFAULT NULL,
  `tanggal_lahir_lama` date DEFAULT NULL,
  `tanggal_lahir_baru` date DEFAULT NULL,
  `status_siswa_lama` enum('Aktif','Tidak Aktif','Pindah','Drop Out') DEFAULT NULL,
  `status_siswa_baru` enum('Aktif','Tidak Aktif','Pindah','Drop Out') DEFAULT NULL,
  `id_kelas_lama` int(10) UNSIGNED DEFAULT NULL,
  `id_kelas_baru` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_tbl_siswas`
--

INSERT INTO `log_tbl_siswas` (`id`, `aksi`, `nipd_lama`, `nipd_baru`, `nisn_lama`, `nisn_baru`, `nama_siswa_lama`, `nama_siswa_baru`, `jk_siswa_lama`, `jk_siswa_baru`, `agama_siswa_lama`, `agama_siswa_baru`, `tempat_lahir_lama`, `tempat_lahir_baru`, `tanggal_lahir_lama`, `tanggal_lahir_baru`, `status_siswa_lama`, `status_siswa_baru`, `id_kelas_lama`, `id_kelas_baru`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Insert', NULL, 1245, NULL, '1234', NULL, 'test', NULL, 'L', NULL, 'Islam', NULL, 'batam', NULL, '2023-12-06', NULL, 'Aktif', NULL, 1, '2023-12-05 20:11:20', '2023-12-05 20:11:20', '2023-12-05 20:11:20'),
(2, 'Update', 1245, NULL, '1234', NULL, 'test', NULL, 'L', NULL, 'Islam', NULL, 'batam', NULL, '2023-12-06', NULL, 'Aktif', NULL, 1, NULL, '2023-12-05 20:11:49', '2023-12-05 20:11:49', '2023-12-05 20:11:49'),
(3, 'Insert', NULL, 123, NULL, '123', NULL, 'Incidunt de', NULL, 'L', NULL, '', NULL, 'Omnis et a p', NULL, '1979-06-28', NULL, 'Aktif', NULL, 8, '2023-12-05 20:23:06', '2023-12-05 20:23:06', '2023-12-05 20:23:06'),
(4, 'Update', 4884, 4884, '0159921812', '0159921812', 'Amira Nasution', 'Amira', 'P', 'P', 'Islam', 'Islam', 'Medans', 'Medan', '2015-09-26', '2015-09-26', 'Aktif', 'Aktif', 4, 4, '2023-12-06 19:26:02', '2023-12-06 19:26:02', '2023-12-06 19:26:02'),
(5, 'Insert', NULL, 12345, NULL, '12345', NULL, 'Sunt quis oc', NULL, 'L', NULL, 'Islam', NULL, 'Iste nisi qu', NULL, '2015-09-24', NULL, 'Tidak Aktif', NULL, 3, '2023-12-06 19:28:38', '2023-12-06 19:28:38', '2023-12-06 19:28:38'),
(6, 'Insert', NULL, 12342, NULL, '123412', NULL, 'test', NULL, 'P', NULL, 'Islam', NULL, 'batu aji', NULL, '2023-12-17', NULL, 'Aktif', NULL, 16, '2023-12-17 05:33:47', '2023-12-17 05:33:47', '2023-12-17 05:33:47'),
(7, 'Insert', NULL, 999999, NULL, '999999', NULL, 'adam', NULL, 'L', NULL, 'Islam', NULL, 'Batam', NULL, '2002-12-04', NULL, 'Aktif', NULL, 16, '2023-12-17 05:37:27', '2023-12-17 05:37:27', '2023-12-17 05:37:27'),
(8, 'Update', 4399, 4399, '0121684678', '0121684678', 'Alfath Aprilio\r\n', 'Alfath Aprilio\r\n', 'L', 'L', 'Islam', 'Islam', 'medan\r\n', 'medan\r\n', '2012-05-09', '2012-05-09', 'Aktif', 'Aktif', 15, 15, '2023-12-19 04:13:29', '2023-12-19 04:13:29', '2023-12-19 04:13:29'),
(9, 'Insert', NULL, 654321, NULL, '123456', NULL, 'testesr', NULL, 'P', NULL, 'Islam', NULL, 'Batam', NULL, '2002-12-04', NULL, 'Aktif', NULL, 1, '2023-12-21 01:07:20', '2023-12-21 01:07:20', '2023-12-21 01:07:20'),
(10, 'Update', 654321, 654321, '123456', '123456', 'testesr', 'testesr', 'P', 'P', 'Islam', 'Islam', 'Batam', 'Batam', '2002-12-04', '2002-12-04', 'Aktif', 'Aktif', 1, 2, '2023-12-21 01:08:09', '2023-12-21 01:08:09', '2023-12-21 01:08:09'),
(11, 'Update', 654321, 654321, '123456', '123456', 'testesr', 'testesr', 'P', 'P', 'Islam', 'Islam', 'Batam', 'Batam', '2002-12-04', '2002-12-04', 'Aktif', 'Aktif', 2, 4, '2023-12-21 01:08:16', '2023-12-21 01:08:16', '2023-12-21 01:08:16'),
(12, 'Update', 654321, 654321, '123456', '123456', 'testesr', 'testesr', 'P', 'P', 'Islam', '', 'Batam', 'Batam', '2002-12-04', '2002-12-04', 'Aktif', 'Aktif', 4, 4, '2023-12-21 01:08:24', '2023-12-21 01:08:24', '2023-12-21 01:08:24'),
(13, 'Update', 654321, 654321, '123456', '123456', 'testesr', 'testesr', 'P', 'P', '', 'Islam', 'Batam', 'Batam', '2002-12-04', '2002-12-04', 'Aktif', '', 4, 4, '2023-12-21 01:08:32', '2023-12-21 01:08:32', '2023-12-21 01:08:32'),
(14, 'Update', 654321, NULL, '123456', NULL, 'testesr', NULL, 'P', NULL, 'Islam', NULL, 'Batam', NULL, '2002-12-04', NULL, '', NULL, 4, NULL, '2023-12-21 01:09:42', '2023-12-21 01:09:42', '2023-12-21 01:09:42'),
(15, 'Update', 12342, NULL, '123412', NULL, 'test', NULL, 'P', NULL, 'Islam', NULL, 'batu aji', NULL, '2023-12-17', NULL, 'Aktif', NULL, 16, NULL, '2023-12-21 01:12:16', '2023-12-21 01:12:16', '2023-12-21 01:12:16'),
(16, 'Update', 12345, NULL, '12345', NULL, 'Sunt quis oc', NULL, 'L', NULL, 'Islam', NULL, 'Iste nisi qu', NULL, '2015-09-24', NULL, 'Tidak Aktif', NULL, 3, NULL, '2023-12-21 01:13:15', '2023-12-21 01:13:15', '2023-12-21 01:13:15'),
(17, 'Update', 123, NULL, '123', NULL, 'Incidunt de', NULL, 'L', NULL, '', NULL, 'Omnis et a p', NULL, '1979-06-28', NULL, 'Aktif', NULL, 8, NULL, '2023-12-21 01:14:20', '2023-12-21 01:14:20', '2023-12-21 01:14:20');

-- --------------------------------------------------------

--
-- Table structure for table `log_tbl_wali_siswas`
--

CREATE TABLE `log_tbl_wali_siswas` (
  `id` int(11) NOT NULL,
  `aksi` enum('Insert','Update','Delete') NOT NULL,
  `nisn_lama` varchar(10) DEFAULT NULL,
  `nisn_baru` varchar(10) DEFAULT NULL,
  `jenis_wali_lama` enum('Ayah','Ibu','Wali') DEFAULT NULL,
  `jenis_wali_baru` enum('Ayah','Ibu','Wali') DEFAULT NULL,
  `nama_wali_lama` varchar(255) DEFAULT NULL,
  `nama_wali_baru` varchar(255) DEFAULT NULL,
  `jenjang_pendidikan_lama` enum('Tidak Sekolah','SD / Sederajat','SMP / Sederajat','SMA / Sederajat','D1 / Sederajat','D2 / Sederajat','D3 / Sederajat','D4 / Sederajat','S1 / Sederajat','S2 / Sederajat','S3 / Sederajat') DEFAULT NULL,
  `jenjang_pendidikan_baru` enum('Tidak Sekolah','SD / Sederajat','SMP / Sederajat','SMA / Sederajat','D1 / Sederajat','D2 / Sederajat','D3 / Sederajat','D4 / Sederajat','S1 / Sederajat','S2 / Sederajat','S3 / Sederajat') DEFAULT NULL,
  `pekerjaan_lama` varchar(255) DEFAULT NULL,
  `pekerjaan_baru` varchar(255) DEFAULT NULL,
  `penghasilan_lama` enum('Tidak Berpenghasilan','Kurang dari Rp 500.000','Rp 500.000 - Rp 999.999','Rp 1.000.000 - Rp 1.999.999','Rp 2.000.000 - Rp 4.999.999','Rp 5.000.000 - Rp 7.999.999') DEFAULT NULL,
  `penghasilan_baru` enum('Tidak Berpenghasilan','Kurang dari Rp 500.000','Rp 500.000 - Rp 999.999','Rp 1.000.000 - Rp 1.999.999','Rp 2.000.000 - Rp 4.999.999','Rp 5.000.000 - Rp 7.999.999') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Stand-in structure for view `mapeldanpengajar`
-- (See below for the actual view)
--
CREATE TABLE `mapeldanpengajar` (
`nama_mapel` varchar(255)
,`nama_guru` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `rosterguru`
-- (See below for the actual view)
--
CREATE TABLE `rosterguru` (
`hari` enum('Senin','Selasa','Rabu','Kamis','Jumat','Sabtu')
,`nama_guru` varchar(255)
,`nama_mapel` varchar(255)
,`waktu_mulai` time
,`waktu_akhir` time
,`kelas` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `rosterkelas`
-- (See below for the actual view)
--
CREATE TABLE `rosterkelas` (
`nama_mapel` varchar(255)
,`waktu_mulai` time
,`waktu_akhir` time
,`hari` enum('Senin','Selasa','Rabu','Kamis','Jumat','Sabtu')
,`nama_kelas` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_akuns`
--

CREATE TABLE `tbl_akuns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nama` varchar(255) NOT NULL,
  `nama_lengkap` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Admin','Guru','Siswa') NOT NULL DEFAULT 'Admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_akuns`
--

INSERT INTO `tbl_akuns` (`id`, `user_id`, `nama`, `nama_lengkap`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, NULL, 'cici', 'Ceycilia', 'cici@admin.com', '$2y$12$0RP.mY.Ke1KYTcvh4D5IE.IV8cO2aTdi5IfsGHVBN8Yu9zBAKBGYi', 'Admin', '2023-12-05 18:49:34', NULL),
(2, NULL, 'admin', 'admin2', 'admin@test.com', '$2y$12$0RP.mY.Ke1KYTcvh4D5IE.IV8cO2aTdi5IfsGHVBN8Yu9zBAKBGYi', 'Admin', '2023-12-05 18:50:44', NULL),
(3, NULL, 'Admin', NULL, 'admin@test.com', '$2y$12$0RP.mY.Ke1KYTcvh4D5IE.IV8cO2aTdi5IfsGHVBN8Yu9zBAKBGYi', 'Admin', '2023-12-14 10:04:36', '2023-12-14 10:04:36'),
(4, 8, 'Guru', NULL, 'guru@test.com', '$2y$12$0RP.mY.Ke1KYTcvh4D5IE.IV8cO2aTdi5IfsGHVBN8Yu9zBAKBGYi', 'Guru', '2023-12-14 10:04:36', '2023-12-14 10:04:36'),
(5, 999999, 'Siswa1', NULL, 'siswa@test.com', '$2y$12$0RP.mY.Ke1KYTcvh4D5IE.IV8cO2aTdi5IfsGHVBN8Yu9zBAKBGYi', 'Siswa', '2023-12-14 10:04:36', '2023-12-14 10:04:36');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_beritas`
--

CREATE TABLE `tbl_beritas` (
  `id_berita` int(11) NOT NULL,
  `id_akun` bigint(20) UNSIGNED NOT NULL,
  `foto_filename` varchar(255) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_beritas`
--

INSERT INTO `tbl_beritas` (`id_berita`, `id_akun`, `foto_filename`, `judul`, `deskripsi`, `created_at`, `updated_at`) VALUES
(11, 2, '7gYUKh4hM5yOxwGvZsuva1Rk4TJsToigNYGOuHl7.png', 'test', 'test', '2023-12-21 04:45:00', '2023-12-21 04:45:00'),
(12, 2, 'yfFHu5xqDp9tKCArpUkyQy7WIu1z3AvX2zBYNK5Y.png', 'a', 'b', '2023-12-21 04:56:47', '2023-12-21 04:56:47');

--
-- Triggers `tbl_beritas`
--
DELIMITER $$
CREATE TRIGGER `delete_berita` BEFORE DELETE ON `tbl_beritas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_beritas 
		(aksi, id_akun_lama, foto_filename_lama, judul_lama, deskripsi_lama, deleted_at)
	VALUES
		('Delete', OLD.id_akun, OLD.foto_filename, OLD.judul, OLD.deskripsi, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_berita` AFTER INSERT ON `tbl_beritas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_beritas 
		(aksi, id_akun_baru, foto_filename_baru, judul_baru, deskripsi_baru, created_at)
	VALUES
		('Insert', NEW.id_akun, NEW.foto_filename, NEW.judul, NEW.deskripsi, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_berita` AFTER UPDATE ON `tbl_beritas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_beritas 
		(aksi, id_akun_lama, id_akun_baru, foto_filename_lama, foto_filename_baru, judul_lama, judul_baru, deskripsi_lama, deskripsi_baru, updated_at)
	VALUES
		('Update', OLD.id_akun, NEW.id_akun, OLD.foto_filename, NEW.foto_filename, OLD.judul, NEW.judul, OLD.deskripsi, NEW.deskripsi, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_bidang_studis`
--

CREATE TABLE `tbl_bidang_studis` (
  `id_mapel` int(11) NOT NULL,
  `nama_mapel` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_bidang_studis`
--

INSERT INTO `tbl_bidang_studis` (`id_mapel`, `nama_mapel`, `created_at`, `updated_at`) VALUES
(1, 'Pendidikan Kewarganegaraan', NULL, NULL),
(2, 'Bahasa Indonesia', NULL, NULL),
(3, 'Matematika', NULL, NULL),
(4, 'Pendidikan Jasmani, Olahraga, dan Kesehatan', NULL, NULL),
(5, 'Pendidikan Agama', NULL, NULL),
(6, 'Projek', NULL, NULL),
(7, 'Seni Budaya dan Keterampilan', NULL, NULL),
(8, 'Tematik', NULL, NULL),
(9, 'Ilmu Pengetahuan Sosial', NULL, NULL),
(10, 'Seni Rupa', NULL, NULL),
(11, 'Ilmu Pengetahuan Alam dan Sosial', NULL, NULL),
(12, 'Muatan Lokal', NULL, NULL),
(13, 'Bahasa Inggris', NULL, NULL),
(14, 'Pengembangan Studi', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ekstrakurikulers`
--

CREATE TABLE `tbl_ekstrakurikulers` (
  `id_ekskul` int(11) NOT NULL,
  `nama_ekstrakurikuler` varchar(255) NOT NULL,
  `pembina_ekskul` varchar(255) NOT NULL,
  `ikon` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_ekstrakurikulers`
--

INSERT INTO `tbl_ekstrakurikulers` (`id_ekskul`, `nama_ekstrakurikuler`, `pembina_ekskul`, `ikon`, `created_at`, `updated_at`) VALUES
(1, 'Pramuka', '', '', NULL, NULL),
(2, 'Drumband', '', '', NULL, NULL),
(3, 'Silat', '', '', NULL, NULL);

--
-- Triggers `tbl_ekstrakurikulers`
--
DELIMITER $$
CREATE TRIGGER `delete_ekskuls` BEFORE DELETE ON `tbl_ekstrakurikulers` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_ekstrakurikulers
		(aksi, nama_ekstrakurikuler_lama, ikon_lama, deleted_at)
	VALUES
		('Delete', OLD.nama_ekstrakurikuler, OLD.ikon, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_ekskuls` AFTER INSERT ON `tbl_ekstrakurikulers` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_ekstrakurikulers
		(aksi, nama_ekstrakurikuler_baru, ikon_baru, created_at)
	VALUES
		('Insert', NEW.nama_ekstrakurikuler, NEW.ikon, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_ekskul` AFTER UPDATE ON `tbl_ekstrakurikulers` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_ekstrakurikulers
		(aksi, nama_ekstrakurikuler_lama, nama_ekstrakurikuler_baru, ikon_lama, ikon_baru, updated_at)
	VALUES
		('Update', OLD.nama_ekstrakurikuler, NEW.nama_ekstrakurikuler, OLD.ikon, NEW.ikon, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ekstrakurikuler_siswas`
--

CREATE TABLE `tbl_ekstrakurikuler_siswas` (
  `id` int(11) NOT NULL,
  `id_ekskul` int(11) NOT NULL,
  `nisn_siswa` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_ekstrakurikuler_siswas`
--

INSERT INTO `tbl_ekstrakurikuler_siswas` (`id`, `id_ekskul`, `nisn_siswa`) VALUES
(1, 1, 112919751),
(2, 1, 117461542),
(3, 2, 121086551),
(4, 2, 121427032),
(6, 1, 122216957),
(7, 3, 125024029),
(9, 3, 112403313),
(10, 3, 112415392);

--
-- Triggers `tbl_ekstrakurikuler_siswas`
--
DELIMITER $$
CREATE TRIGGER `delete_ekskul_siswa` BEFORE DELETE ON `tbl_ekstrakurikuler_siswas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_ekstrakurikuler_siswas
    	(aksi, id_ekskul_lama, nisn_siswa_lama, deleted_at)
	VALUES
    	('Delete', OLD.id_ekskul, OLD.nisn_siswa, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_ekskul_siswa` AFTER INSERT ON `tbl_ekstrakurikuler_siswas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_ekstrakurikuler_siswas
    	(aksi, id_ekskul_baru, nisn_siswa_baru, created_at)
	VALUES
    	('Insert', NEW.id_ekskul, NEW.nisn_siswa, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_ekskul_siswa` AFTER UPDATE ON `tbl_ekstrakurikuler_siswas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_ekstrakurikuler_siswas
    	(aksi, id_ekskul_baru, id_ekskul_lama, nisn_siswa_baru, nisn_siswa_lama, updated_at)
	VALUES
    	('Update', NEW.id_ekskul, OLD.id_ekskul, NEW.nisn_siswa, OLD.nisn_siswa, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_fasilitas`
--

CREATE TABLE `tbl_fasilitas` (
  `id_fasilitas` int(11) NOT NULL,
  `nama_fasilitas` varchar(255) DEFAULT NULL,
  `foto_fasilitas` varchar(255) DEFAULT NULL,
  `deskripsi` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_fasilitas`
--

INSERT INTO `tbl_fasilitas` (`id_fasilitas`, `nama_fasilitas`, `foto_fasilitas`, `deskripsi`, `created_at`, `updated_at`) VALUES
(1, 'Tempat Ibadah', NULL, 'Tempat ibadah SD AL ITTIHADIYAH Laut Dendang', NULL, NULL),
(2, 'Ruang TU', NULL, 'Ruang Tata Usaha SD AL ITTIHADIYAH Laut Dendang', NULL, NULL),
(3, 'Ruang Perpustakaan', NULL, 'Perpustakaan SD AL ITTIHADIYAH Laut Dendang', NULL, NULL),
(4, 'Ruang Guru', NULL, 'Ruang Guru SD AL ITTIHADIYAH Laut Dendang', NULL, NULL),
(5, 'Ruang Kelas', NULL, 'Ruang Kelas SD AL ITTIHADIYAH Laut Dendang', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_gurus`
--

CREATE TABLE `tbl_gurus` (
  `id_guru` int(11) NOT NULL,
  `nama_guru` varchar(255) NOT NULL,
  `ket_guru` varchar(100) NOT NULL,
  `status_guru` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_gurus`
--

INSERT INTO `tbl_gurus` (`id_guru`, `nama_guru`, `ket_guru`, `status_guru`, `created_at`) VALUES
(1, 'Linda Siti Zulaikha, S.Pd', 'Non-PNS', 'Aktif', NULL),
(2, 'Siti Warohmah', 'Non-PNS', 'Aktif', NULL),
(3, 'Andi Putra Batubara', 'Non-PNS', 'Aktif', NULL),
(4, 'Ali Rahman, S.Pd.I', 'Non-PNS', 'Aktif', NULL),
(5, 'Chairul Azmi Lubis, S.Pd', 'Non-PNS', 'Aktif', NULL),
(6, 'Riri Andrian, S.Pd', 'Non-PNS', 'Aktif', NULL),
(7, 'Sri Wedari, S.Ag', 'Non-PNS', 'Aktif', NULL),
(8, 'Nurlia Ayuni, S.Pd', 'Non-PNS', 'Aktif', NULL),
(9, 'Mariani, S.Pd.I', 'Non-PNS', 'Aktif', NULL),
(10, 'Nahfazul Fauziah Harahap, S.Pd', 'Non-PNS', 'Aktif', NULL),
(11, 'Salmah, S.Ag', 'Non-PNS', 'Aktif', NULL),
(12, 'Susilawati, S.Ag', 'Non-PNS', 'Aktif', NULL),
(13, 'Laily Ramadhani, S.Pd, M.Ak', 'Non-PNS', 'Aktif', NULL),
(14, 'Nuranisa, S.Pd.I', 'Non-PNS', 'Aktif', NULL),
(15, 'Rudi Ahmad, S.Pd.I', 'Non-PNS', 'Aktif', NULL),
(16, 'Seri Wahyuni, S.Pd.I', 'Non-PNS', 'Aktif', NULL),
(17, 'Masitah, S.Pd.I', 'Non-PNS', 'Aktif', NULL),
(18, 'Qatrunnada, S.Pd.I', 'Non-PNS', 'Aktif', NULL),
(19, 'Maimunah. Bb, S.Sos', 'Non-PNS', 'Aktif', NULL),
(20, 'Nuraini, SE', 'Non-PNS', 'Aktif', NULL),
(21, 'Alvy Hayati Nur', 'Non-PNS', 'Aktif', NULL);

--
-- Triggers `tbl_gurus`
--
DELIMITER $$
CREATE TRIGGER `delete_gurus` BEFORE DELETE ON `tbl_gurus` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_gurus
		(aksi, nama_guru_lama, ket_guru_lama, status_guru_lama, deleted_at)
	VALUES
		('Delete', OLD.nama_guru, OLD.ket_guru, OLD.status_guru, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_guru` AFTER INSERT ON `tbl_gurus` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_gurus
		(aksi, nama_guru_baru, ket_guru_baru, status_guru_baru, created_at)
	VALUES
		('Insert', NEW.nama_guru, NEW.ket_guru, NEW.status_guru, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_guru` AFTER UPDATE ON `tbl_gurus` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_gurus
		(aksi, nama_guru_baru, nama_guru_lama, ket_guru_baru, ket_guru_lama, status_guru_baru, status_guru_lama, updated_at)
	VALUES
		('Update', NEW.nama_guru, OLD.nama_guru,  NEW.ket_guru, OLD.ket_guru, OLD.status_guru, NEW.status_guru, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_kelas`
--

CREATE TABLE `tbl_kelas` (
  `id_kelas` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `wali_kelas` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_kelas`
--

INSERT INTO `tbl_kelas` (`id_kelas`, `nama`, `wali_kelas`, `created_at`) VALUES
(1, 'I-A', 7, NULL),
(2, 'I-B', 9, NULL),
(3, 'I-C', 17, NULL),
(4, 'II-A', 10, NULL),
(5, 'II-B', 9, NULL),
(6, 'II-C', 11, NULL),
(7, 'III-A', 8, NULL),
(8, 'III-B', 12, NULL),
(9, 'IV-A', 21, NULL),
(10, 'IV-B', 13, NULL),
(11, 'IV-C', 15, NULL),
(12, 'V-A', 14, NULL),
(13, 'V-B', 15, NULL),
(14, 'V-C', 19, NULL),
(15, 'VI-A', 18, NULL),
(16, 'VI-B', 20, NULL);

--
-- Triggers `tbl_kelas`
--
DELIMITER $$
CREATE TRIGGER `delete_kelas` BEFORE DELETE ON `tbl_kelas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_kelas
		(aksi, nama_lama, wali_kelas_lama, deleted_at)
	VALUES
		('Delete', OLD.nama, OLD.wali_kelas, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_kelas` AFTER INSERT ON `tbl_kelas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_kelas
		(aksi, nama_baru, wali_kelas_baru, created_at)
	VALUES
		('Insert', NEW.nama, NEW.wali_kelas, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_kelas` AFTER UPDATE ON `tbl_kelas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_kelas
		(aksi, nama_lama, nama_baru, wali_kelas_lama, wali_kelas_baru, updated_at)
	VALUES
		('Update', OLD.nama, NEW.nama, OLD.wali_kelas, NEW.wali_kelas, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_mapel_gurus`
--

CREATE TABLE `tbl_mapel_gurus` (
  `id` int(11) NOT NULL,
  `id_guru` int(11) NOT NULL,
  `id_mapel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_mapel_gurus`
--

INSERT INTO `tbl_mapel_gurus` (`id`, `id_guru`, `id_mapel`) VALUES
(1, 7, 3),
(2, 7, 7),
(3, 9, 3),
(4, 9, 7),
(5, 17, 3),
(6, 17, 7),
(7, 10, 3),
(8, 10, 7),
(9, 9, 3),
(10, 9, 7),
(11, 11, 2),
(12, 11, 7),
(13, 8, 2),
(14, 8, 9),
(15, 8, 11),
(16, 12, 3),
(17, 12, 7),
(18, 21, 3),
(19, 21, 9),
(20, 21, 10),
(21, 21, 7),
(22, 21, 11),
(23, 13, 3),
(24, 13, 9),
(25, 13, 10),
(26, 13, 11),
(27, 13, 7),
(28, 15, 3),
(29, 15, 9),
(30, 15, 10),
(31, 15, 11),
(32, 15, 7),
(33, 14, 8),
(34, 14, 7),
(35, 14, 14),
(36, 15, 12),
(37, 15, 8),
(38, 15, 7),
(39, 15, 14),
(40, 19, 8),
(41, 19, 7),
(42, 19, 14),
(43, 18, 8),
(44, 18, 7),
(45, 18, 14),
(46, 20, 8),
(47, 20, 7),
(48, 20, 14),
(49, 1, 1),
(50, 2, 13),
(51, 3, 4),
(52, 4, 5),
(53, 5, 5),
(54, 6, 4),
(55, 7, 2),
(56, 8, 3),
(57, 9, 2),
(58, 10, 2),
(59, 11, 3),
(60, 12, 2),
(61, 13, 2),
(62, 14, 12),
(63, 15, 2),
(64, 16, 11),
(65, 17, 2),
(66, 18, 3),
(67, 19, 12),
(68, 20, 3),
(69, 21, 2);

--
-- Triggers `tbl_mapel_gurus`
--
DELIMITER $$
CREATE TRIGGER `delete_mapel_gurus` BEFORE DELETE ON `tbl_mapel_gurus` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_mapel_gurus
		(aksi, id_guru_lama, id_mapel_lama, deleted_at)
	VALUES
		('Delete', OLD.id_guru, OLD.id_mapel, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_mapel_gurus` BEFORE INSERT ON `tbl_mapel_gurus` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_mapel_gurus
		(aksi, id_guru_baru, id_mapel_baru, created_at)
	VALUES
		('Insert', NEW.id_guru, NEW.id_mapel, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_mapel_gurus` AFTER UPDATE ON `tbl_mapel_gurus` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_mapel_gurus
		(aksi, id_guru_lama, id_guru_baru, id_mapel_lama, id_mapel_baru, updated_at)
	VALUES
		('Update', OLD.id_guru, NEW.id_guru, OLD.id_mapel, NEW.id_mapel, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_nilais`
--

CREATE TABLE `tbl_nilais` (
  `id_nilai` int(11) NOT NULL,
  `nisn_siswa` bigint(20) UNSIGNED NOT NULL,
  `jenis_nilai` varchar(255) NOT NULL,
  `id_mapel` int(11) NOT NULL,
  `id_guru` int(11) NOT NULL,
  `nilai` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_nilais`
--

INSERT INTO `tbl_nilais` (`id_nilai`, `nisn_siswa`, `jenis_nilai`, `id_mapel`, `id_guru`, `nilai`) VALUES
(1, 999999, 'uh1', 2, 21, 15);

--
-- Triggers `tbl_nilais`
--
DELIMITER $$
CREATE TRIGGER `delete_nilai` BEFORE DELETE ON `tbl_nilais` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_nilais
		(aksi, nisn_siswa_lama, jenis_nilai_lama, id_mapel_lama, id_guru_lama, nilai_lama, deleted_at)
	VALUES
		('Delete', OLD.nisn_siswa, OLD.jenis_nilai, OLD.id_mapel, OLD.id_guru, OLD.nilai, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_nilai` AFTER INSERT ON `tbl_nilais` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_nilais
		(aksi, nisn_siswa_baru, jenis_nilai_baru, id_mapel_baru, id_guru_baru, nilai_baru, created_at)
	VALUES
		('Insert', NEW.nisn_siswa, NEW.jenis_nilai, NEW.id_mapel, NEW.id_guru, NEW.nilai, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_nilai` AFTER UPDATE ON `tbl_nilais` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_nilais
		(aksi, nisn_siswa_lama, nisn_siswa_baru, jenis_nilai_lama, jenis_nilai_baru, id_mapel_lama, id_mapel_baru, id_guru_lama, id_guru_baru, nilai_lama, nilai_baru, updated_at)
	VALUES
		('Insert', OLD.nisn_siswa, NEW.nisn_siswa, OLD.jenis_nilai, NEW.jenis_nilai, OLD.id_mapel, NEW.id_mapel, OLD.id_guru, NEW.id_guru, OLD.nilai, NEW.nilai, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validasi_nilai` BEFORE INSERT ON `tbl_nilais` FOR EACH ROW BEGIN 
IF NEW.nilai < 0 OR NEW.nilai > 100 THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nilai harus di antara 0-100';
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pegawais`
--

CREATE TABLE `tbl_pegawais` (
  `id_pegawai` int(11) NOT NULL,
  `nama_pegawai` varchar(255) NOT NULL,
  `jk_pegawai` varchar(20) NOT NULL,
  `ket_pegawai` varchar(255) NOT NULL,
  `status_pegawai` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_pegawais`
--

INSERT INTO `tbl_pegawais` (`id_pegawai`, `nama_pegawai`, `jk_pegawai`, `ket_pegawai`, `status_pegawai`, `created_at`, `updated_at`) VALUES
(1, 'Elfi Nurmansyah', 'L', 'Penjaga Sekolah', 'Aktif', NULL, '2023-12-21 05:13:52'),
(2, 'Linda Siti Zulaikha', 'P', 'Kepala Sekolah', 'Nonaktif', NULL, '2023-12-21 03:06:34'),
(3, 'Mahmun Saputra', 'L', 'Petugas Keamanan/Kebersihan', 'Aktif', NULL, NULL),
(4, 'Nuranisa Aini', 'P', 'Operator Sekolah', 'Aktif', NULL, NULL);

--
-- Triggers `tbl_pegawais`
--
DELIMITER $$
CREATE TRIGGER `delete_pegawai` BEFORE DELETE ON `tbl_pegawais` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_pegawais 
		(aksi, nama_pegawai_lama, ket_pegawai_lama, jk_pegawai_lama, status_pegawai_lama, deleted_at)
	VALUES
		('Delete', OLD.nama_pegawai, OLD.ket_pegawai, OLD.jk_pegawai, OLD.status_pegawai, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_pegawai` AFTER INSERT ON `tbl_pegawais` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_pegawais 
		(aksi, nama_pegawai_baru, ket_pegawai_baru, jk_pegawai_baru, status_pegawai_baru, created_at)
	VALUES
		('Insert', NEW.nama_pegawai, NEW.ket_pegawai, NEW.jk_pegawai, NEW.status_pegawai, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_pegawai` AFTER UPDATE ON `tbl_pegawais` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_pegawais 
		(aksi, nama_pegawai_lama, nama_pegawai_baru, ket_pegawai_lama, ket_pegawai_baru, jk_pegawai_lama, jk_pegawai_baru, status_pegawai_lama, status_pegawai_baru, updated_at)
	VALUES
		('Update', OLD.nama_pegawai, NEW.nama_pegawai, OLD.ket_pegawai, NEW.ket_pegawai, OLD.jk_pegawai, NEW.jk_pegawai, OLD.status_pegawai, NEW.status_pegawai, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_prestasis`
--

CREATE TABLE `tbl_prestasis` (
  `id_prestasi` int(11) NOT NULL,
  `nama_prestasi` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_prestasis`
--

INSERT INTO `tbl_prestasis` (`id_prestasi`, `nama_prestasi`, `deskripsi`, `created_at`, `updated_at`) VALUES
(1, 'test', 'testod', '2023-12-18 13:58:49', '2023-12-18 14:05:25');

--
-- Triggers `tbl_prestasis`
--
DELIMITER $$
CREATE TRIGGER `delete_prestasi` BEFORE DELETE ON `tbl_prestasis` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_prestasis
		(aksi, nama_prestasi_lama, deskripsi_lama, deleted_at)
	VALUES
		('Delete', OLD.nama_prestasi, OLD.deskripsi, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_prestasi` AFTER INSERT ON `tbl_prestasis` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_prestasis
		(aksi, nama_prestasi_baru, deskripsi_baru, created_at)
	VALUES
		('Insert', NEW.nama_prestasi, NEW.deskripsi, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_prestasi` AFTER UPDATE ON `tbl_prestasis` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_prestasis
		(aksi, nama_prestasi_lama, nama_prestasi_baru, deskripsi_lama, deskripsi_baru, updated_at)
	VALUES
		('Update', OLD.nama_prestasi, NEW.nama_prestasi, OLD.deskripsi, NEW.deskripsi, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_rosters`
--

CREATE TABLE `tbl_rosters` (
  `roster_id` bigint(20) NOT NULL,
  `mapel_guru` int(11) NOT NULL,
  `kelas` int(11) NOT NULL,
  `tahun_ajaran_aktif` char(9) NOT NULL,
  `semester_aktif` enum('Ganjil','Genap') NOT NULL,
  `waktu_mulai` time NOT NULL,
  `waktu_akhir` time NOT NULL,
  `hari` enum('Senin','Selasa','Rabu','Kamis','Jumat','Sabtu') NOT NULL,
  `created_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_rosters`
--

INSERT INTO `tbl_rosters` (`roster_id`, `mapel_guru`, `kelas`, `tahun_ajaran_aktif`, `semester_aktif`, `waktu_mulai`, `waktu_akhir`, `hari`, `created_at`) VALUES
(1, 55, 1, '2023/2024', 'Genap', '07:30:00', '08:00:00', 'Senin', NULL),
(2, 55, 1, '2023/2024', 'Genap', '08:00:00', '08:30:00', 'Senin', NULL),
(3, 55, 1, '2023/2024', 'Genap', '08:30:00', '09:00:00', 'Senin', NULL),
(4, 1, 1, '2023/2024', 'Genap', '09:15:00', '09:45:00', 'Senin', NULL),
(5, 1, 1, '2023/2024', 'Genap', '09:45:00', '10:15:00', 'Senin', NULL),
(6, 55, 1, '2023/2024', 'Genap', '07:30:00', '08:00:00', 'Selasa', NULL),
(7, 55, 1, '2023/2024', 'Genap', '08:00:00', '08:30:00', 'Selasa', NULL),
(8, 55, 1, '2023/2024', 'Genap', '08:30:00', '09:00:00', 'Selasa', NULL),
(9, 1, 1, '2023/2024', 'Genap', '09:15:00', '09:45:00', 'Selasa', NULL),
(10, 1, 1, '2023/2024', 'Genap', '09:45:00', '10:15:00', 'Selasa', NULL),
(11, 1, 1, '2023/2024', 'Genap', '07:30:00', '08:00:00', 'Rabu', NULL),
(12, 1, 1, '2023/2024', 'Genap', '08:00:00', '08:30:00', 'Rabu', NULL),
(13, 55, 1, '2023/2024', 'Genap', '08:30:00', '09:00:00', 'Rabu', NULL),
(14, 55, 1, '2023/2024', 'Genap', '09:15:00', '09:45:00', 'Rabu', NULL),
(15, 55, 1, '2023/2024', 'Genap', '09:45:00', '10:15:00', 'Rabu', NULL),
(16, 49, 1, '2023/2024', 'Genap', '07:30:00', '08:00:00', 'Kamis', NULL),
(17, 49, 1, '2023/2024', 'Genap', '08:00:00', '08:30:00', 'Kamis', NULL),
(18, 49, 1, '2023/2024', 'Genap', '08:30:00', '09:00:00', 'Kamis', NULL),
(19, 55, 1, '2023/2024', 'Genap', '09:15:00', '09:45:00', 'Kamis', NULL),
(20, 55, 1, '2023/2024', 'Genap', '09:45:00', '10:15:00', 'Kamis', NULL),
(21, 52, 1, '2023/2024', 'Genap', '07:30:00', '08:00:00', 'Jumat', NULL),
(22, 52, 1, '2023/2024', 'Genap', '08:00:00', '08:30:00', 'Jumat', NULL),
(23, 52, 1, '2023/2024', 'Genap', '08:30:00', '09:00:00', 'Jumat', NULL),
(24, 49, 1, '2023/2024', 'Genap', '09:15:00', '09:45:00', 'Jumat', NULL),
(25, 2, 1, '2023/2024', 'Genap', '07:30:00', '08:00:00', 'Sabtu', NULL),
(26, 2, 1, '2023/2024', 'Genap', '08:00:00', '08:30:00', 'Sabtu', NULL),
(27, 54, 1, '2023/2024', 'Genap', '08:30:00', '09:00:00', 'Sabtu', NULL),
(28, 54, 1, '2023/2024', 'Genap', '09:15:00', '09:45:00', 'Sabtu', NULL),
(29, 58, 4, '2023/2024', 'Genap', '10:30:00', '11:00:00', 'Senin', NULL),
(30, 58, 4, '2023/2024', 'Genap', '11:00:00', '11:30:00', 'Senin', NULL),
(32, 7, 4, '2023/2024', 'Genap', '12:15:00', '12:45:00', 'Senin', NULL),
(33, 7, 4, '2023/2024', 'Genap', '12:45:00', '13:15:00', 'Senin', NULL),
(34, 7, 4, '2023/2024', 'Genap', '10:30:00', '11:00:00', 'Selasa', NULL),
(35, 7, 4, '2023/2024', 'Genap', '11:00:00', '11:30:00', 'Selasa', NULL),
(36, 7, 4, '2023/2024', 'Genap', '11:30:00', '12:00:00', 'Selasa', NULL),
(37, 58, 4, '2023/2024', 'Genap', '12:15:00', '12:45:00', 'Selasa', NULL),
(38, 58, 4, '2023/2024', 'Genap', '12:45:00', '13:15:00', 'Selasa', NULL),
(39, 49, 4, '2023/2024', 'Genap', '10:30:00', '11:00:00', 'Rabu', NULL),
(40, 49, 4, '2023/2024', 'Genap', '11:00:00', '11:30:00', 'Rabu', NULL),
(41, 49, 4, '2023/2024', 'Genap', '11:30:00', '12:00:00', 'Rabu', NULL),
(42, 58, 4, '2023/2024', 'Genap', '12:15:00', '12:45:00', 'Rabu', NULL),
(43, 58, 4, '2023/2024', 'Genap', '12:45:00', '13:15:00', 'Rabu', NULL),
(44, 58, 4, '2023/2024', 'Genap', '10:30:00', '11:00:00', 'Kamis', NULL),
(45, 58, 4, '2023/2024', 'Genap', '11:00:00', '11:30:00', 'Kamis', NULL),
(46, 58, 4, '2023/2024', 'Genap', '11:30:00', '12:00:00', 'Kamis', NULL),
(47, 7, 4, '2023/2024', 'Genap', '12:15:00', '12:45:00', 'Kamis', NULL),
(48, 7, 4, '2023/2024', 'Genap', '12:45:00', '13:15:00', 'Kamis', NULL),
(49, 7, 4, '2023/2024', 'Genap', '10:30:00', '11:00:00', 'Jumat', NULL),
(50, 7, 4, '2023/2024', 'Genap', '11:00:00', '11:30:00', 'Jumat', NULL),
(51, 52, 4, '2023/2024', 'Genap', '11:30:00', '12:00:00', 'Jumat', NULL),
(53, 51, 4, '2023/2024', 'Genap', '10:30:00', '11:00:00', 'Sabtu', NULL),
(54, 51, 4, '2023/2024', 'Genap', '11:00:00', '11:30:00', 'Sabtu', NULL),
(55, 8, 4, '2023/2024', 'Genap', '11:30:00', '12:00:00', 'Sabtu', NULL),
(56, 8, 4, '2023/2024', 'Genap', '12:00:00', '12:15:00', 'Sabtu', NULL);

--
-- Triggers `tbl_rosters`
--
DELIMITER $$
CREATE TRIGGER `insert_roster` AFTER INSERT ON `tbl_rosters` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_rosters
    	(aksi, mapel_guru_baru, kelas_baru, tahun_ajaran_aktif_baru, semester_aktif_baru, waktu_mulai_baru, waktu_akhir_baru, hari_baru, created_at)
	VALUES
    	('Insert', NEW.mapel_guru, NEW.kelas, NEW.tahun_ajaran_aktif, NEW.semester_aktif, NEW.waktu_mulai, NEW.waktu_akhir, NEW.hari, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_roster` AFTER UPDATE ON `tbl_rosters` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_rosters
    	(aksi, mapel_guru_lama, mapel_guru_baru, kelas_lama, kelas_baru, tahun_ajaran_aktif_lama, tahun_ajaran_aktif_baru, semester_aktif_lama, semester_aktif_baru, waktu_mulai_lama, waktu_mulai_baru, waktu_akhir_lama, waktu_akhir_baru, hari_lama, hari_baru, updated_at)
	VALUES
    	('Update', OLD.mapel_guru, NEW.mapel_guru, OLD.kelas, NEW.kelas, OLD.tahun_ajaran_aktif, NEW.tahun_ajaran_aktif, OLD.semester_aktif, NEW.semester_aktif, OLD.waktu_mulai, NEW.waktu_mulai, OLD.waktu_akhir, NEW.waktu_akhir, NEW.hari, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_siswas`
--

CREATE TABLE `tbl_siswas` (
  `nisn` bigint(20) UNSIGNED NOT NULL,
  `nipd` int(11) NOT NULL,
  `nama_siswa` varchar(255) NOT NULL,
  `jk_siswa` varchar(20) NOT NULL,
  `agama_siswa` varchar(50) NOT NULL,
  `tempat_lahir` varchar(255) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `status_siswa` varchar(100) NOT NULL,
  `id_kelas` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_siswas`
--

INSERT INTO `tbl_siswas` (`nisn`, `nipd`, `nama_siswa`, `jk_siswa`, `agama_siswa`, `tempat_lahir`, `tanggal_lahir`, `status_siswa`, `id_kelas`, `created_at`, `updated_at`) VALUES
(999999, 999999, 'adam', 'L', 'islam', 'Batam', '2002-12-04', 'Aktif', 16, NULL, NULL),
(111172557, 4412, 'Dilla Mahera\r\n', 'P', 'islam', 'sigli\r\n', '2011-06-21', 'Aktif', 15, NULL, NULL),
(112403313, 4464, 'Reza Dwi Andika', 'L', 'islam', 'Laut Dendang', '2011-12-31', 'Aktif', 16, NULL, NULL),
(112415392, 4402, 'Alief Frandika', 'L', 'islam', 'kolam', '2011-12-06', 'Aktif', 16, NULL, NULL),
(112464967, 4465, 'Ridhuan', 'L', 'islam', 'Medan', '2011-12-27', 'Aktif', 16, NULL, NULL),
(112919751, 4427, 'KAMAL MAULANA HARAHAP\r\n', 'L', 'islam', 'BANDAR KHALIPAH\r\n', '2011-05-05', 'Aktif', 15, NULL, NULL),
(113327378, 4414, 'Dini Anggraini', 'P', 'islam', 'Medan', '2011-11-26', 'Aktif', 16, NULL, NULL),
(116826680, 4469, 'Risky Aditia Nugroho', 'L', 'islam', 'Laut Dendang', '2011-05-26', 'Aktif', 16, NULL, NULL),
(117461542, 4420, 'Fadillah Ahmad', 'L', 'islam', 'Laut Dendang', '2011-12-01', 'Aktif', 16, NULL, NULL),
(118969993, 4397, 'Adetya\r\n', 'L', 'islam', 'medan\r\n', '2011-08-04', 'Aktif', 15, NULL, NULL),
(121086551, 4999, 'KINANTI PUTRI DWI MAULANA\r\n', 'P', 'islam', 'MEDAN\r\n', '2012-11-29', 'Aktif', 16, NULL, NULL),
(121302996, 4425, 'Irvan Khadavi', 'L', 'islam', 'Laut Dendang', '2012-10-09', 'Aktif', 16, NULL, NULL),
(121427032, 4400, 'Alfiani Nowilia Safitri', 'P', 'islam', 'Laut Dendang', '2012-11-06', 'Aktif', 16, NULL, NULL),
(121647881, 4423, 'Harnita Nadya Auliyah\r\n', 'P', 'islam', 'batam\r\n', '2012-05-12', 'Aktif', 15, NULL, NULL),
(121684678, 4399, 'Alfath Aprilio\r\n', 'L', 'islam', 'medan\r\n', '2012-05-09', 'Aktif', 15, '2023-12-19 04:13:24', NULL),
(121918089, 4430, 'M. Ahwan Aldiansyah\r\n', 'L', 'islam', 'laut dendang\r\n', '2012-07-27', 'Aktif', 15, NULL, NULL),
(121965764, 4555, 'Putri Alya BR Pane\r\n', 'P', 'islam', 'MEDAN\r\n', '2011-12-01', 'Aktif', 13, NULL, NULL),
(122216957, 4873, 'Afika Fitria', 'P', 'islam', 'Pisang Pala', '2012-06-20', 'Aktif', 6, NULL, NULL),
(122285445, 4457, 'Raffiqa Radhila', 'P', 'islam', 'Medan', '2012-05-18', 'Aktif', 16, NULL, NULL),
(122572975, 4431, 'M. Arya Afandi\r\n', 'L', 'islam', 'laut dendang\r\n', '2012-05-27', 'Aktif', 14, NULL, NULL),
(122829943, 4405, 'Amelia Syahfitri', 'P', 'islam', 'Laut Dendang', '2012-03-20', 'Aktif', 16, NULL, NULL),
(123011525, 4475, 'Vindeza Cipta', 'L', 'islam', 'Medan', '2012-05-02', 'Aktif', 16, NULL, NULL),
(123219434, 4419, 'Fadhil Syahnata', 'L', 'islam', 'Laut Dendang', '2012-01-01', 'Aktif', 16, NULL, NULL),
(124012757, 4339, 'Muhammad Abil', 'L', 'islam', 'Medan Estate', '2012-08-09', 'Aktif', 16, NULL, NULL),
(124521764, 4429, 'M. Aditya\r\n', 'L', 'islam', 'banda aceh\r\n', '2012-03-06', 'Aktif', 15, NULL, NULL),
(125024029, 4466, 'Ririn Dwi Yanti', 'P', 'islam', 'Laut Dendang', '2012-12-14', 'Aktif', 16, NULL, NULL),
(125077963, 4463, 'Revan Syaban Albuqohri', 'L', 'islam', 'Laut Dendang', '2012-06-27', 'Aktif', 16, NULL, NULL),
(125349355, 4474, 'Theo Didik Pratama', 'L', 'islam', 'Bandar Setia', '2012-04-04', 'Aktif', 16, NULL, NULL),
(125523717, 4462, 'Rapa Fanduwi', 'L', 'islam', 'Batubara', '2012-01-16', 'Aktif', 16, NULL, NULL),
(125578023, 4437, 'Mhd. Rafa Naufal Kamil', 'L', 'islam', 'Medan', '2012-06-29', 'Aktif', 16, NULL, NULL),
(125619208, 4417, 'Fachri Ramadhan\r\n', 'L', 'islam', 'medan\r\n', '2012-08-16', 'Aktif', 15, NULL, NULL),
(126132073, 4478, 'Yoga Pratama', 'L', 'islam', 'Batubara', '2012-04-17', 'Aktif', 16, NULL, NULL),
(126487608, 5026, 'M Ikhsan Al Ragil\r\n', 'L', 'islam', 'Deli Serdang\r\n', '2012-06-28', 'Aktif', 13, NULL, NULL),
(126825440, 4591, 'Zakhy Ferdiansyah\r\n', 'L', 'islam', 'Medan\r\n', '2012-09-18', 'Aktif', 13, NULL, NULL),
(126889152, 4458, 'Raiqah Rachmad Nasution', 'P', 'islam', 'Medan', '2012-10-02', 'Aktif', 16, NULL, NULL),
(127210210, 4450, 'Nazwa Lutfiyah', 'P', 'islam', 'Medan', '2012-09-17', 'Aktif', 16, NULL, NULL),
(127511284, 4410, 'Azhari Alif Andika\r\n', 'L', 'islam', 'medan\r\n', '2012-02-02', 'Aktif', 15, NULL, NULL),
(127673587, 4645, 'DWI ARYA PRATAMA\r\n', 'L', 'islam', 'MEDAN\r\n', '2012-09-09', 'Aktif', 11, NULL, NULL),
(127823420, 4526, 'Kaisa Devilia', 'P', 'islam', 'Laut Dendang', '2012-11-19', 'Aktif', 12, NULL, NULL),
(127949295, 4735, 'Bagus Prasetyo', 'L', 'islam', 'Langkat', '2012-06-12', 'Aktif', 16, NULL, NULL),
(128005889, 4418, 'Fadhil Guntara Matondang\r\n', 'L', 'islam', 'laut dendang\r\n', '2012-10-13', 'Aktif', 15, NULL, NULL),
(128283086, 4422, 'Hardiansyah Reyhan Pratama\r\n', 'L', 'islam', 'laut dendang\r\n', '2012-03-02', 'Aktif', 15, NULL, NULL),
(128487431, 4403, 'Alief Pratama Silalahi', 'L', 'islam', 'Medan', '2012-07-16', 'Aktif', 16, NULL, NULL),
(128526738, 4436, 'Mhd. Alda Wira', 'L', 'islam', 'Medan Estate', '2012-06-23', 'Aktif', 16, NULL, NULL),
(128766400, 4426, 'Jelita Mutiara Putri\r\n', 'P', 'islam', 'laut dendang\r\n', '2012-08-23', 'Aktif', 15, '2023-11-03 10:03:31', NULL),
(129263104, 4416, 'DWI ATTIQAAH PUTRI\r\n', 'P', 'islam', 'LAUT DENDANG\r\n', '2012-07-08', 'Aktif', 15, NULL, NULL),
(129431541, 4439, 'Muhammad Azzam', 'L', 'islam', 'Medan', '2012-01-04', 'Aktif', 16, NULL, NULL),
(129498271, 4533, 'Muhammad Abdul Dzakiy', 'L', 'islam', 'Bangun Rejo', '2012-12-31', 'Aktif', 12, NULL, NULL),
(129581447, 4470, 'Riziq Akbar', 'L', 'islam', 'Laut Dendang', '2012-05-10', 'Aktif', 16, NULL, NULL),
(129678964, 4455, 'Prabu Arya Rasidin Ahmad', 'L', 'islam', 'Sei Rotan', '2012-02-27', 'Aktif', 16, NULL, NULL),
(129743302, 5023, 'Cut Nisyah Aulia\r\n', 'P', 'islam', 'Medan\r\n', '2012-12-12', 'Aktif', 13, NULL, NULL),
(131273654, 4659, 'Hazizah\r\n', 'P', 'islam', 'Medan\r\n', '2013-10-10', 'Aktif', 9, NULL, NULL),
(131387655, 4531, 'Mada Al Fatih', 'L', 'islam', 'Tembung', '2013-07-20', 'Aktif', 12, NULL, NULL),
(132029823, 4628, 'Amar Joyo Handoko', 'L', 'islam', 'Langkat', '2013-10-20', 'Aktif', 10, NULL, NULL),
(132126026, 4706, 'Rivansyah Dewa\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-04-11', 'Aktif', 11, NULL, NULL),
(133157633, 5022, 'Alifia Aishyah Zahra\r\n', 'P', 'islam', 'Langkat\r\n', '2013-11-11', 'Aktif', 13, NULL, NULL),
(133408195, 4514, 'Cahaya Balqis\r\n', 'P', 'islam', 'Medan\r\n', '2013-06-01', 'Aktif', 14, NULL, NULL),
(133482268, 4518, 'Dirga Pramana Putra', 'L', 'islam', 'Laut Dendang', '2013-06-18', 'Aktif', 12, NULL, NULL),
(134370080, 4508, 'Armada Jaya Hadi Lubis\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-10-18', 'Aktif', 14, NULL, NULL),
(134549386, 5020, 'KESYA NABILA PUTRI\r\n', 'P', 'islam', 'LAUT DENDANG\r\n', '2013-06-18', 'Aktif', 13, NULL, NULL),
(136321102, 4496, 'Adibah Mey Safrina', 'P', 'islam', 'Laut Dendang', '2013-05-26', 'Aktif', 12, NULL, NULL),
(136979298, 5011, 'Audy Angkasa\r\n', 'P', 'islam', 'Medan\r\n', '2015-10-09', 'Aktif', 7, NULL, NULL),
(137746589, 4520, 'Eza Al Vino', 'L', 'islam', 'Laut Dendang', '2013-09-21', 'Aktif', 12, NULL, NULL),
(137862056, 4563, 'Rara Irdina', 'P', 'islam', 'Kota Tengah', '2013-04-22', 'Aktif', 12, NULL, NULL),
(138023318, 4576, 'Suci Amelia\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2013-05-10', 'Aktif', 13, NULL, NULL),
(138796352, 4881, 'Alfathan Fredy Asyah', 'L', 'islam', 'Binjai', '2015-12-15', 'Aktif', 5, NULL, NULL),
(139760118, 4513, 'Bunga Khairunnisa', 'P', 'islam', 'Medan', '2013-10-29', 'Aktif', 12, NULL, NULL),
(141415799, 4712, 'Sheddiq Raffa Purnama Manurung\r\n', 'L', 'islam', 'Medan\r\n', '2014-02-27', 'Aktif', 11, NULL, NULL),
(141421503, 4637, 'Azka Huzaifah', 'L', 'islam', 'Langkat', '2014-08-11', 'Aktif', 10, NULL, NULL),
(141722399, 4714, 'Syaqilla Dwi Almira\r\n', 'P', 'islam', 'Medan\r\n', '2014-05-29', 'Aktif', 11, NULL, NULL),
(142407474, 4656, 'Habibi\r\n', 'L', 'islam', 'Medan\r\n', '2014-04-10', 'Aktif', 10, NULL, NULL),
(142522058, 4642, 'Devila Ramadhani\r\n', 'P', 'islam', 'Medan\r\n', '2014-07-05', 'Aktif', 7, NULL, NULL),
(142817972, 4673, 'Muhammad Aditya\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2014-07-24', 'Aktif', 11, NULL, NULL),
(143098302, 4630, 'Anhu Khairi Ardhin\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2014-10-30', 'Aktif', 9, NULL, NULL),
(143627734, 4688, 'Nayra Ramadhani\r\n', 'P', 'islam', 'Bandar Khalipah\r\n', '2014-07-14', 'Aktif', 11, NULL, NULL),
(144539399, 4661, 'Kirana Kellen\r\n', 'P', 'islam', 'Prabumulih\r\n', '2014-07-05', 'Aktif', 9, NULL, NULL),
(147629217, 4679, 'Muhammad Riyan Ramadan\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2014-06-26', 'Aktif', 9, NULL, NULL),
(147840265, 4814, 'Nabilla Aprila\r\n', 'P', 'islam', 'Medan\r\n', '2014-04-26', 'Aktif', 8, NULL, NULL),
(148828864, 4681, 'Nadien Putri Amelia\r\n', 'P', 'islam', 'Medan\r\n', '2014-06-08', 'Aktif', 11, NULL, NULL),
(152722565, 4805, 'M. Zulfikri\r\n', 'L', 'islam', 'Medan\r\n', '2015-01-25', 'Aktif', 7, NULL, NULL),
(159921812, 4884, 'Amira', 'P', 'islam', 'Medans', '2015-09-26', 'Aktif', 4, '2023-12-06 19:26:02', NULL),
(3104413859, 5012, 'Andika Syaputra\r\n', 'P', 'islam', 'Medan\r\n', '2010-05-27', 'Aktif', 7, NULL, NULL),
(3110560808, 4409, 'AULIA NATASYA\r\n', 'P', 'islam', 'SIDEMPUAN\r\n', '2011-09-11', 'Aktif', 15, NULL, NULL),
(3110720379, 5006, 'Kanaya Azzura Harahap\r\n', 'P', 'islam', 'Medan\r\n', '2011-09-19', 'Aktif', 14, NULL, NULL),
(3112883586, 4411, 'Bima Batara Al Sani\r\n', 'L', 'islam', 'Bandar Setia\r\n', '2011-11-07', 'Aktif', 15, NULL, NULL),
(3112936976, 5021, 'RANGGA PRATAMA\r\n', 'L', 'islam', 'Bandar Setia\r\n', '2012-12-27', 'Aktif', 13, NULL, NULL),
(3114993252, 4408, 'Assifa Syakira\r\n', 'P', 'islam', 'medan\r\n', '2011-12-06', 'Aktif', 15, NULL, NULL),
(3115923861, 4556, 'Putri Anita\r\n', 'P', 'islam', 'Medan\r\n', '2011-10-30', 'Aktif', 13, NULL, NULL),
(3116729075, 4461, 'Rangga Ramadhan Pangaribuan', 'L', 'islam', 'Bandar Setia', '2011-08-12', 'Aktif', 16, NULL, NULL),
(3118799397, 4993, 'Inayah Alifia Syachrani\r\n', 'P', 'islam', 'Medan\r\n', '2011-11-04', 'Aktif', 15, NULL, NULL),
(3121142720, 4521, 'Fahmi Fahrezi', 'L', 'islam', 'Medan Estate', '2012-07-26', 'Aktif', 12, NULL, NULL),
(3121535615, 5027, 'Al Mushawwiru Zaky\r\n', 'L', 'islam', 'Medan Estate\r\n', '2012-12-26', 'Aktif', 13, NULL, NULL),
(3122517292, 4406, 'ANAR KHY SUHARNAN\r\n', 'L', 'islam', 'SIBARUANG\r\n', '2012-06-03', 'Aktif', 15, NULL, NULL),
(3123605240, 4535, 'Muhammad Al Hafiizhi', 'L', 'islam', 'Tembung', '2012-12-31', 'Aktif', 12, NULL, NULL),
(3123755937, 4424, 'Indri Aulia', 'P', 'islam', 'Medan', '2012-01-24', 'Aktif', 16, NULL, NULL),
(3124420502, 4557, 'Putry Sry Rezeky', 'P', 'islam', 'Medan', '2012-12-30', 'Aktif', 12, NULL, NULL),
(3124539802, 4527, 'Khairunisa\r\n', 'P', 'islam', 'Medan\r\n', '2012-12-25', 'Aktif', 13, NULL, NULL),
(3125307366, 4537, 'Muhammad Fajar Al Musanif\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2012-10-13', 'Aktif', 13, NULL, NULL),
(3125384119, 4734, 'Abdi Riski Hamdani', 'L', 'islam', 'Sei Mencirim', '2012-06-01', 'Aktif', 16, NULL, NULL),
(3125405642, 4337, 'Miftahul Jannah', 'P', 'islam', 'Laut Dendang', '2012-11-20', 'Aktif', 16, NULL, NULL),
(3126666968, 4401, 'Alfino Fajar Siregar', 'L', 'islam', 'Medan', '2012-04-05', 'Aktif', 16, NULL, NULL),
(3127308888, 4567, 'Rizki Ramadhani\r\n', 'L', 'islam', 'Bandar Khalipah\r\n', '2012-08-08', 'Aktif', 13, NULL, NULL),
(3127327970, 4995, 'Aziiz Jamiil\r\n', 'L', 'islam', 'Medan\r\n', '2012-02-06', 'Aktif', 15, NULL, NULL),
(3127484318, 4511, 'Bintang Maharani\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2012-10-21', 'Aktif', 14, NULL, NULL),
(3127646794, 5024, 'Muhammad Rianda Pratama\r\n', 'L', 'islam', 'P. Johar\r\n', '2012-02-03', 'Aktif', 13, NULL, NULL),
(3128004903, 4562, 'Raisa Khairani', 'P', 'islam', 'Medan', '2012-12-26', 'Aktif', 12, NULL, NULL),
(3128821352, 4566, 'Riski Alpian\r\n', 'L', 'islam', 'Medan Estate\r\n', '2012-09-26', 'Aktif', 13, NULL, NULL),
(3129164952, 5025, 'Ramadhan Husein\r\n', 'L', 'islam', 'Medan\r\n', '2012-11-12', 'Aktif', 10, NULL, NULL),
(3129445780, 4577, 'Suci Anggraini\r\n', 'P', 'islam', 'Medan\r\n', '2012-08-19', 'Aktif', 13, NULL, NULL),
(3129630694, 4545, 'Nabila Syakila Raya', 'P', 'islam', 'Laut Dendang', '2012-11-02', 'Aktif', 12, NULL, NULL),
(3130098937, 4647, 'Egi Herdiansyah\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-11-21', 'Aktif', 9, NULL, NULL),
(3131158265, 4584, 'Tri Aurel Sopadilla\r\n', 'P', 'islam', 'Medan\r\n', '2013-10-30', 'Aktif', 13, NULL, NULL),
(3131717373, 4582, 'Syifa Amelia\r\n', 'P', 'islam', 'Langkat\r\n', '2013-01-05', 'Aktif', 13, NULL, NULL),
(3131974435, 4651, 'Farid Azhar Siregar\r\n', 'L', 'islam', 'Medan\r\n', '2013-08-05', 'Aktif', 9, NULL, NULL),
(3132112194, 4640, 'Bimbi Alamsyah', 'L', 'islam', 'Medan', '2013-04-27', 'Aktif', 6, NULL, NULL),
(3132177763, 4588, 'Wira Fitra Sanjaya\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-08-12', 'Aktif', 13, NULL, NULL),
(3132213003, 4507, 'Aprilliya Gusnana Salim Bangun\r\n', 'P', 'islam', 'Medan\r\n', '2013-04-14', 'Aktif', 14, NULL, NULL),
(3132214854, 4657, 'Hadiansyah Putra\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-10-10', 'Aktif', 11, NULL, NULL),
(3132265729, 4698, 'Putri Anggraini\r\n', 'P', 'islam', 'Medan\r\n', '2013-12-04', 'Aktif', 7, NULL, NULL),
(3132352474, 5028, 'Sofiah Solehah\r\n', 'P', 'islam', 'Batam\r\n', '2013-01-01', 'Aktif', 13, NULL, NULL),
(3132359715, 4530, 'M. Bagas Prakoso Sahputra\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-04-12', 'Aktif', 14, NULL, NULL),
(3132372335, 4538, 'Muhammad Farid Alfiqri\r\n', 'L', 'islam', 'Medan\r\n', '2013-07-02', 'Aktif', 13, NULL, NULL),
(3132431803, 4522, 'Febryka Triani\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2013-03-18', 'Aktif', 13, NULL, NULL),
(3132770037, 4641, 'Dafa Pratama\r\n', 'L', 'islam', 'Lubuk Sabau\r\n', '2013-10-14', 'Aktif', 11, NULL, NULL),
(3132949244, 4565, 'Rifqi\r\n', 'L', 'islam', 'Sampali\r\n', '2013-05-21', 'Aktif', 13, NULL, NULL),
(3133071670, 4649, 'Fairah Naylatul Izzah Noor\r\n', 'P', 'islam', 'Bandar Setia\r\n', '2013-10-26', 'Aktif', 11, NULL, NULL),
(3133295476, 4655, 'Gilang Alviano\r\n', 'L', 'islam', 'Malaysia\r\n', '2013-07-15', 'Aktif', 11, NULL, NULL),
(3133302028, 4523, 'Fero Al Bian', 'L', 'islam', 'Laut Dendang', '2013-09-15', 'Aktif', 12, NULL, NULL),
(3133379581, 4515, 'Cantika Putri Ajuini\r\n', 'P', 'islam', 'Medan\r\n', '2013-06-05', 'Aktif', 14, NULL, NULL),
(3133726814, 4573, 'SANICAH', 'P', 'islam', 'Laut Dendang', '2013-04-24', 'Aktif', 12, NULL, NULL),
(3133968405, 4504, 'Alifa Rizka Khairani\r\n', 'P', 'islam', 'Medan\r\n', '2013-08-19', 'Aktif', 13, NULL, NULL),
(3134062366, 4625, 'Aisyah Safriani Harahap\r\n', 'P', 'islam', 'Tembung\r\n', '2013-11-09', 'Aktif', 11, NULL, NULL),
(3134424647, 4680, 'Muhammad Saddam Shayfullah\r\n', 'L', 'islam', 'Medan\r\n', '2013-11-18', 'Aktif', 11, NULL, NULL),
(3134831099, 4497, 'Afifah Mahira', 'P', 'islam', 'Medan Estate', '2013-10-19', 'Aktif', 12, NULL, NULL),
(3135162157, 4509, 'Aufa Al Rasyid Lubis\r\n', 'L', 'islam', 'Medan\r\n', '2013-01-10', 'Aktif', 14, NULL, NULL),
(3135283395, 4653, 'Fitri Anjani\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2013-10-19', 'Aktif', 9, NULL, NULL),
(3135455225, 5005, 'JOREITA SEMBIRING\r\n', 'P', 'islam', 'MEDAN\r\n', '2013-07-27', 'Aktif', 14, NULL, NULL),
(3135712782, 4737, 'Alya Febiyanti\r\n\r\n', 'P', 'islam', 'Medan\r\n', '2013-02-16', 'Aktif', 14, NULL, NULL),
(3136017780, 4506, 'Anugrah Ferdiansyah\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-02-11', 'Aktif', 14, NULL, NULL),
(3136182679, 4517, 'Daru Dwi Prawira\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-05-28', 'Aktif', 13, NULL, NULL),
(3136222445, 2021, 'Rizky Perasetiyo\r\n', 'L', 'islam', 'Medan\r\n', '2013-03-06', 'Aktif', 8, NULL, NULL),
(3136417741, 4669, 'Mhd Farhan Nasution', 'L', 'islam', 'Medan', '2013-10-24', 'Aktif', 10, NULL, NULL),
(3136489121, 5074, 'Fathan Anugerah Hubaini', 'L', 'islam', 'Medan', '2013-10-19', 'Aktif', 10, NULL, NULL),
(3136720456, 4662, 'Lasmana Prasetian\r\n', 'L', 'islam', 'Medan Estate\r\n', '2013-01-17', 'Aktif', 11, NULL, NULL),
(3136929608, 4666, 'M. Yusuf Al-Syaidi', 'L', 'islam', 'Medan', '2013-11-05', 'Aktif', 10, NULL, NULL),
(3137062523, 4693, 'Nur Ain\r\n', 'P', 'islam', 'Medan\r\n', '2013-12-26', 'Aktif', 11, NULL, NULL),
(3137094997, 4510, 'Ayunda Azzahra\r\n', 'P', 'islam', 'Medan\r\n', '2013-04-10', 'Aktif', 14, NULL, NULL),
(3137311870, 4536, 'Muhammad Alduwin', 'L', 'islam', 'Laut Dendang', '2013-01-05', 'Aktif', 12, NULL, NULL),
(3137590732, 4519, 'Dyo Febriansyah', 'L', 'islam', 'Laut Dendang', '2013-02-26', 'Aktif', 12, NULL, NULL),
(3137694925, 4578, 'Suci Dafina\r\n', 'P', 'islam', 'Binjai\r\n', '2013-08-07', 'Aktif', 13, NULL, NULL),
(3137799710, 4500, 'Aidil Akbar\r\n', 'L', 'islam', 'Medan\r\n', '2013-08-11', 'Aktif', 13, NULL, NULL),
(3137831353, 4539, 'Muhammad Krisna\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-02-08', 'Aktif', 13, NULL, NULL),
(3137875688, 4678, 'Muhammad Rasyid Septian', 'L', 'islam', 'Medan', '2013-09-20', 'Aktif', 10, NULL, NULL),
(3138010649, 4796, 'Hamilah Habsari\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2013-11-30', 'Aktif', 8, NULL, NULL),
(3138193007, 4817, 'Nayla Yasmin\r\n', 'L', 'islam', 'Sampali\r\n', '2013-10-11', 'Aktif', 7, NULL, NULL),
(3138367847, 4676, 'Muhammad Getar Syuhada', 'L', 'islam', 'Medan', '2013-12-27', 'Aktif', 10, NULL, NULL),
(3138689153, 4501, 'Aina Talita Zahran\r\n', 'P', 'islam', 'Medan Estate\r\n', '2013-08-10', 'Aktif', 14, NULL, NULL),
(3138728041, 4561, 'Rahmad Darmawan Lubis', 'L', 'islam', 'Medan Estate', '2013-11-26', 'Aktif', 12, NULL, NULL),
(3138748026, 4823, 'Nurin Eiliyah Parinduri\r\n', 'P', 'islam', 'Tanjung Morawa\r\n', '2013-12-01', 'Aktif', 7, NULL, NULL),
(3138821566, 4672, 'Muamar Zain', 'L', 'islam', 'Tangerang', '2013-12-18', 'Aktif', 10, NULL, NULL),
(3138980141, 4633, 'Aqila Salsabila\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2013-09-20', 'Aktif', 7, NULL, NULL),
(3139205645, 4674, 'Muhammad Alfarizi', 'L', 'islam', 'Medan', '2013-04-03', 'Aktif', 10, NULL, NULL),
(3139295314, 4512, 'Bulan Ramadhany Arfan Lubis\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2013-07-11', 'Aktif', 13, NULL, NULL),
(3139391320, 4554, 'Padli Fadilah', 'L', 'islam', 'Laut Dendang', '2013-05-08', 'Aktif', 12, NULL, NULL),
(3139485730, 5004, 'Azmi Aulifa\r\n', 'L', 'islam', 'Perbaungan\r\n', '2013-04-21', 'Aktif', 14, NULL, NULL),
(3139703462, 4547, 'Najla Dwi Bintang', 'P', 'islam', 'Laut Dendang', '2013-03-20', 'Aktif', 12, NULL, NULL),
(3139709493, 4550, 'Nur Shina Kayla\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2013-03-23', 'Aktif', 13, NULL, NULL),
(3139841208, 4648, 'Fachry Luthfy', 'L', 'islam', 'Deli Serdang', '2013-12-11', 'Aktif', 10, NULL, NULL),
(3140288638, 4838, 'Wila Datul Hasanah Hasibuan\r\n', 'P', 'islam', 'Medan\r\n', '2014-12-27', 'Aktif', 8, NULL, NULL),
(3140303763, 4808, 'Muhammad Azrul Ramadhan\r\n', 'L', 'islam', 'Medan\r\n', '2014-06-20', 'Aktif', 7, NULL, NULL),
(3140403159, 4802, 'M. Dimas Darma Wangsa\r\n', 'L', 'islam', 'Medan\r\n', '2014-09-10', 'Aktif', 8, NULL, NULL),
(3140479053, 4836, 'Tirta Ardiansyah\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2014-11-27', 'Aktif', 8, NULL, NULL),
(3140626689, 4818, 'Nazla Qanita Siregar\r\n', 'P', 'islam', 'Medan\r\n', '2014-11-29', 'Aktif', 8, NULL, NULL),
(3140756387, 5030, 'Aisyah Marsha\r\n', 'P', 'islam', 'Medan\r\n', '2014-02-03', 'Aktif', 7, NULL, NULL),
(3140867394, 4840, 'Zikrie Azhar Raihan\r\n', 'L', 'islam', 'Medan\r\n', '2014-10-28', 'Aktif', 7, NULL, NULL),
(3140898934, 4683, 'Nafira Saqilah', 'P', 'islam', 'Laut Dendang', '2014-03-15', 'Aktif', 10, NULL, NULL),
(3141035046, 4646, 'Eggy Maulana\r\n', 'L', 'islam', 'Diski\r\n', '2014-02-25', 'Aktif', 9, NULL, NULL),
(3141337940, 4827, 'Rafa Fauzan Ghani\r\n', 'L', 'islam', 'Medan\r\n', '2014-01-19', 'Aktif', 8, NULL, NULL),
(3141504477, 4775, 'Azka Adhyasta Santoso\r\n', 'L', 'islam', 'Medan\r\n', '2014-12-29', 'Aktif', 7, NULL, NULL),
(3141626572, 4639, 'Bilqis Kanza Talita', 'P', 'islam', 'Laut Dendang', '2014-05-05', 'Aktif', 10, NULL, NULL),
(3141648512, 4820, 'Nicko Ardinata\r\n', 'L', 'islam', 'Tembung\r\n', '2014-08-22', 'Aktif', 8, NULL, NULL),
(3141786410, 4667, 'Mhd Alwi Ramadan Lubis\r\n', 'L', 'islam', 'Medan\r\n', '2014-06-04', 'Aktif', 9, NULL, NULL),
(3141929894, 4631, 'Annafiz Sahqir Murtado', 'L', 'islam', 'Laut Dendang', '2014-02-19', 'Aktif', 6, NULL, NULL),
(3141977021, 4634, 'Atika Azra Naidina\r\n', 'P', 'islam', 'Medan\r\n', '2014-04-01', 'Aktif', 11, NULL, NULL),
(3142021462, 4682, 'Nadira Andara Lintang Nasution\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2014-08-26', 'Aktif', 9, NULL, NULL),
(3142205925, 4911, 'Dwi Bulan Handayani', 'P', 'islam', 'Medan\r\n', '2014-11-17', 'Aktif', 4, NULL, NULL),
(3142357061, 4652, 'Fernando Natalyo', 'L', 'islam', 'Medan', '2014-05-21', 'Aktif', 6, NULL, NULL),
(3142519987, 4848, 'Muhammad El-Buhari', 'L', 'islam', 'Medan', '2014-11-02', 'Aktif', 6, NULL, NULL),
(3142764556, 4638, 'Balqis Zivana Putri', 'P', 'islam', 'Medan', '2014-04-13', 'Aktif', 10, NULL, NULL),
(3142768663, 4684, 'Nafisah Muharrami Zain\r\n', 'P', 'islam', 'Medan', '2014-10-31', 'Aktif', 9, NULL, NULL),
(3143024915, 5032, 'DESWA SALSABILA\r\n', 'P', 'islam', 'MEDAN\r\n', '2014-09-21', 'Aktif', 7, NULL, NULL),
(3143044044, 4675, 'Muhammad Fauzi Al Sandi', 'L', 'islam', 'Medan Estate', '2014-02-28', 'Aktif', 10, NULL, NULL),
(3143109089, 5037, 'Zira Antanovia\r\n', 'P', 'islam', 'Simalungun\r\n', '2014-11-12', 'Aktif', 8, NULL, NULL),
(3143148307, 4824, 'Nurul Amelia MT\r\n', 'P', 'islam', 'Medan\r\n', '2014-10-15', 'Aktif', 7, NULL, NULL),
(3143189824, 4665, 'M. Rizky Maulana\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2014-06-08', 'Aktif', 7, NULL, NULL),
(3143703485, 4664, 'M. Rizki Affandi', 'L', 'islam', 'Bandar Khalipah', '2014-04-03', 'Aktif', 10, NULL, NULL),
(3143823968, 4671, 'Miyana Puspita\r\n', 'P', '', 'Sampali\r\n', '2014-03-15', 'Aktif', 9, NULL, NULL),
(3143927473, 4710, 'Salsabila Azzahra\r\n', 'P', 'islam', 'Medan\r\n', '2014-07-27', 'Aktif', 11, NULL, NULL),
(3143979209, 4830, 'Rezky Prasetyo\r\n', 'L', 'islam', 'Medan\r\n', '2014-09-09', 'Aktif', 8, NULL, NULL),
(3144361665, 4701, 'Rafa Al Zikri\r\n', 'L', 'islam', 'Medan\r\n', '2014-07-19', 'Aktif', 11, NULL, NULL),
(3144536776, 4977, 'Yoga Kurniawan Dalimunthe', 'L', 'islam', 'Medan', '2014-04-11', 'Aktif', 4, NULL, NULL),
(3144616373, 4799, 'Khafi El Hamam Parinduri\r\n', 'L', 'islam', 'Medan\r\n', '2014-12-04', 'Aktif', 8, NULL, NULL),
(3144970498, 4839, 'Yadi\r\n', 'L', 'islam', 'Medan Estate\r\n', '2014-12-03', 'Aktif', 8, NULL, NULL),
(3145127315, 4835, 'Surya Gemilang', 'L', 'islam', 'Laut Dendang', '2014-11-15', 'Aktif', 5, NULL, NULL),
(3145515773, 4761, 'Aidil Akbar', 'L', 'islam', 'Laut Dendang', '2014-10-04', 'Aktif', 5, NULL, NULL),
(3145678900, 4650, 'Fakhira Salwa Ramadani\r\n', 'P', 'islam', 'Medan\r\n', '2014-07-02', 'Aktif', 11, NULL, NULL),
(3145981910, 4677, 'Muhammad Manaf Nasution', 'L', 'islam', 'Medan', '2013-12-27', 'Aktif', 10, NULL, NULL),
(3146021657, 4704, 'Reno Al-Farizi\r\n', 'L', 'islam', 'Medan\r\n', '2014-09-10', 'Aktif', 11, NULL, NULL),
(3146311718, 4654, 'Gibran Fabio Aska', 'L', 'islam', 'Medan', '2013-10-19', 'Aktif', 10, NULL, NULL),
(3146851083, 4626, 'Al Fathir Abiyu\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2014-02-19', 'Aktif', 7, NULL, NULL),
(3147089616, 4807, 'Mimifa Khairunnisa\r\n', 'P', 'islam', 'Bandar Khalipah\r\n', '2014-08-17', 'Aktif', 7, NULL, NULL),
(3147158592, 4629, 'Andini Putri Pratama\r\n', 'P', 'islam', 'Medan\r\n', '2014-06-03', 'Aktif', 11, NULL, NULL),
(3147300170, 4837, 'Ufaira Nur Afifa\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2014-04-10', 'Aktif', 7, NULL, NULL),
(3147589325, 4770, 'Arjuna Arya Al-Qohar\r\n', 'L', 'islam', 'Dumai\r\n', '2014-02-08', 'Aktif', 8, NULL, NULL),
(3147851930, 4689, 'Nayra Sahbillah Azharah\r\n', 'P', 'islam', 'Bandar Setia\r\n', '2014-08-12', 'Aktif', 9, NULL, NULL),
(3148231089, 4841, 'Alika Naila Putri\r\n', 'P', 'islam', 'Bandar Khalipah\r\n', '2014-06-23', 'Aktif', 8, NULL, NULL),
(3148301517, 4660, 'Khairil Fahri\r\n', 'L', 'islam', 'Medan\r\n', '2014-01-02', 'Aktif', 11, NULL, NULL),
(3148332130, 4691, 'Nazihah Muharrami Zain\r\n', 'P', 'islam', 'Medan\r\n', '2014-10-31', 'Aktif', 9, NULL, NULL),
(3148592006, 4813, 'Mutiya Zafira\r\n', 'P', 'islam', 'Medan\r\n', '2014-11-09', 'Aktif', 7, NULL, NULL),
(3148594164, 4636, 'Azizah Puspitasari\r\n', 'P', 'islam', 'Medan\r\n', '2014-04-06', 'Aktif', 11, NULL, NULL),
(3148788815, 4764, 'Alfa Aditya\r\n', 'L', 'islam', 'Medan\r\n', '2014-05-01', 'Aktif', 7, NULL, NULL),
(3148795966, 4760, 'Agung Prawira\r\n', 'L', 'islam', 'Medan\r\n', '2014-11-16', 'Aktif', 7, NULL, NULL),
(3148797859, 4834, 'Siti Humairah\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2014-12-20', 'Aktif', 8, NULL, NULL),
(3148975146, 4658, 'Hasby Rahman Lubis', 'L', 'islam', 'Medan', '2014-07-10', 'Aktif', 10, NULL, NULL),
(3149096407, 4644, 'Duwi Julianti', 'P', 'islam', 'Dumai', '2014-06-04', 'Aktif', 10, NULL, NULL),
(3149648071, 4627, 'Al Nadhif Putra Sundana\r\n', 'L', 'islam', 'Medan\r\n', '2014-06-14', 'Aktif', 9, NULL, NULL),
(3149654138, 4663, 'M. Alcantara Zaffran\r\n', 'L', 'islam', 'Medan\r\n', '2014-05-09', 'Aktif', 11, NULL, NULL),
(3149726016, 5035, 'Putri Thalita Ulfa\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2014-03-08', 'Aktif', 8, NULL, NULL),
(3150068038, 4932, 'M. Aziz Maulana', 'L', 'islam', 'Medan Estate', '2015-12-12', 'Aktif', 5, NULL, NULL),
(3150108687, 4901, 'Chila Mikayla', 'P', 'islam', 'Laut Dendang', '2015-12-28', 'Aktif', 5, NULL, NULL),
(3150260443, 4826, 'Raditya Pratama\r\n', 'L', 'islam', 'Medan\r\n', '2015-03-21', 'Aktif', 7, NULL, NULL),
(3150283414, 4904, 'Daffa Pranaja', 'L', 'islam', 'Medan', '2015-10-09', 'Aktif', 4, NULL, NULL),
(3150517546, 4871, 'Adelia Putri', 'P', 'islam', 'Medan', '2015-10-06', 'Aktif', 5, NULL, NULL),
(3150519547, 4880, 'Al Rizky Falistira', 'L', 'islam', 'Laut Dendang', '2015-09-17', 'Aktif', 6, NULL, NULL),
(3150664836, 4964, 'Raisya Rahma', 'P', 'islam', 'B. Khalipah', '2015-08-05', 'Aktif', 4, NULL, NULL),
(3150949421, 4846, 'Nadia Azzahra\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2015-01-13', 'Aktif', 8, NULL, NULL),
(3151265721, 4800, 'Khaira Syahfitri\r\n', 'P', 'islam', 'Sampali\r\n', '2015-07-26', 'Aktif', 8, NULL, NULL),
(3151405271, 4961, 'Raffi Dary Abiyyu', 'L', 'islam', 'Medan', '2015-09-12', 'Aktif', 4, NULL, NULL),
(3151463658, 4768, 'Annaura Yasmine\r\n', 'P', 'islam', 'Bandar Selamat\r\n', '2015-04-12', 'Aktif', 7, NULL, NULL),
(3151600636, 4792, 'Febrian Syahputra\r\n', 'L', 'islam', 'Tembung\r\n', '2015-02-21', 'Aktif', 8, NULL, NULL),
(3151653011, 5034, 'MUHAMMAD RAYHAN REFIKANZAH\r\n', 'L', 'islam', 'Bandar Setia\r\n', '2015-01-05', 'Aktif', 8, NULL, NULL),
(3151750034, 4844, 'Ihsan Akmal', 'L', 'islam', 'Medan', '2015-05-31', 'Aktif', 5, NULL, NULL),
(3151773197, 4908, 'Desy Rahma Sari', 'P', 'islam', 'Laut Dendang', '2015-12-16', 'Aktif', 6, NULL, NULL),
(3151860080, 4947, 'Muhammad Satria', 'L', 'islam', 'Medan', '2015-02-28', 'Aktif', 4, NULL, NULL),
(3151898759, 4902, 'Cleopatra Rensy', 'L', 'islam', 'Medan', '2015-12-28', 'Aktif', 6, NULL, NULL),
(3152015709, 4907, 'Denis Pratama', 'L', 'islam', 'Laut Dendang', '2015-07-10', 'Aktif', 5, NULL, NULL),
(3152049803, 4903, 'Dafa', 'L', 'islam', 'Laut Dendang', '2015-10-27', 'Aktif', 4, NULL, NULL),
(3152136053, 4791, 'Febiyana', 'P', 'islam', 'Medan', '2015-02-06', 'Aktif', 4, NULL, NULL),
(3152285539, 4795, 'Hafiza Al-Malika\r\n', 'P', 'islam', 'Bandar Setia\r\n', '2015-02-13', 'Aktif', 8, NULL, NULL),
(3152516173, 4883, 'Alfi Andra Aditya', 'L', 'islam', 'Medan', '2015-10-04', 'Aktif', 5, NULL, NULL),
(3152534706, 4825, 'Nurul Putri Kharimah\r\n', 'P', 'islam', 'Medan Estatet\r\n', '2015-07-10', 'Aktif', 8, NULL, NULL),
(3152614399, 4785, 'Doli Al-Hafiz Zaky\r\n', 'L', 'islam', 'Medan Estate\r\n', '2015-03-12', 'Aktif', 8, NULL, NULL),
(3152691268, 4975, 'Vino Raditya', 'L', 'islam', 'Binjai\r\n', '2015-07-03', 'Aktif', 4, NULL, NULL),
(3152751369, 4969, 'Salsabila', 'P', 'islam', 'Medan', '2015-08-26', 'Aktif', 5, NULL, NULL),
(3153039218, 4984, 'Imam Ali', 'L', 'islam', 'Medan', '2015-02-20', 'Aktif', 5, NULL, NULL),
(3153103412, 4801, 'M. Alfazan\r\n', 'L', 'islam', 'Medan Estate\r\n', '2015-10-23', 'Aktif', 8, NULL, NULL),
(3153176485, 4921, 'Hafizah Khayyirah Lubna\r\n', 'P', 'islam', 'Depok\r\n', '2015-05-13', 'Aktif', 8, NULL, NULL),
(3153311551, 4874, 'Aisyah Koriah', 'P', 'islam', 'Medan', '2015-02-21', 'Aktif', 6, NULL, NULL),
(3153346241, 4772, 'Arka Syafatir Al-Hakim\r\n', 'L', 'islam', 'Medan\r\n', '2015-06-17', 'Aktif', 7, NULL, NULL),
(3153501218, 4976, 'Virza Andara', 'L', 'islam', 'Laut Dendang', '2015-12-24', 'Aktif', 5, NULL, NULL),
(3153796358, 4829, 'Rania Putri\r\n', 'P', 'islam', 'Medan\r\n', '2015-04-28', 'Aktif', 8, NULL, NULL),
(3153950133, 4788, 'Eza Irawan Syahputra\r\n', 'L', 'islam', 'Medan Estate\r\n', '2015-08-26', 'Aktif', 7, NULL, NULL),
(3154141448, 4798, 'Keyla Saputri\r\n', 'L', 'islam', 'Bandar Setia\r\n', '2015-01-18', 'Aktif', 7, NULL, NULL),
(3154303778, 4954, 'Nazwa Khairani Putri', 'P', 'islam', 'Medan', '2015-12-25', 'Aktif', 4, NULL, NULL),
(3154599737, 4762, 'Akila Sahira Nasution\r\n', 'P', 'islam', 'Bandar Khalipah\r\n', '2015-03-10', 'Aktif', 7, NULL, NULL),
(3154936826, 4822, 'Nuria Rahmah\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2015-01-22', 'Aktif', 8, NULL, NULL),
(3155218654, 4941, 'Muhammad Fariz Akbar', 'L', 'islam', 'Bandar Setia', '2015-08-25', 'Aktif', 5, NULL, NULL),
(3155462364, 4819, 'Nazwa Rahmadina Prasetio\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2015-07-04', 'Aktif', 7, NULL, NULL),
(3155746449, 4816, 'Naura Balqis Suwanika\r\n', 'P', 'islam', 'Medan\r\n', '2015-09-15', 'Aktif', 8, NULL, NULL),
(3155810073, 4797, 'Juan Rodis Silalahi\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2015-04-02', 'Aktif', 7, NULL, NULL),
(3155880886, 5036, 'SYAUQI RAMADHAN JUANDA\r\n', 'L', 'islam', 'KLUMPANG KAMPUNG\r\n', '2015-07-14', 'Aktif', 8, NULL, NULL),
(3156386590, 4893, 'Asyifa Yuwandira', 'P', 'islam', 'Medan', '2015-08-14', 'Aktif', 6, NULL, NULL),
(3156403436, 4905, 'Dedek Aldiansyah', 'L', 'islam', 'Pelawan', '2015-10-14', 'Aktif', 6, NULL, NULL),
(3156439610, 4963, 'Raisa Syahputri Siregar', 'P', 'islam', 'Medan', '2015-01-02', 'Aktif', 4, NULL, NULL),
(3156468955, 4968, 'Rizky Dwi Anggara', 'L', 'islam', 'Medan', '2015-11-24', 'Aktif', 5, NULL, NULL),
(3156559077, 4886, 'Andini Safitri', 'P', 'islam', 'Medan', '2015-07-28', 'Aktif', 5, NULL, NULL),
(3156726778, 4909, 'Dinda Kirana', 'P', 'islam', 'Medan', '2015-07-08', 'Aktif', 6, NULL, NULL),
(3156811377, 4809, 'Muhammad Dzaki Al Mair\r\n', 'L', 'islam', 'Medan\r\n', '2015-02-20', 'Aktif', 7, NULL, NULL),
(3157255269, 4946, 'Muhammad Rama', 'L', 'islam', 'Laut Dendang', '2015-03-01', 'Aktif', 4, NULL, NULL),
(3157264546, 4786, 'Dwi Meilany\r\n', 'P', 'islam', 'Aceh Barat\r\n', '2015-05-07', 'Aktif', 8, NULL, NULL),
(3157285352, 4793, 'Gista Khairani\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2015-07-05', 'Aktif', 7, NULL, NULL),
(3157583099, 4912, 'Enjeli Purnama', 'P', 'islam', 'Medan', '2015-05-23', 'Aktif', 4, NULL, NULL),
(3157754103, 4779, 'Beby Pertiwi\r\n', 'P', 'islam', 'Medan\r\n', '2015-09-16', 'Aktif', 7, NULL, NULL),
(3157795443, 4766, 'Andhika Iskandar Manik\r\n', 'L', 'islam', 'Medan\r\n', '2015-05-07', 'Aktif', 8, NULL, NULL),
(3157951624, 4794, 'Haafidzah Aznii Yuwandiera\r\n', 'P', 'islam', 'Medan Estate\r\n', '2015-02-04', 'Aktif', 8, NULL, NULL),
(3158036666, 4882, 'Alfazar', 'L', 'islam', 'Medan Estate', '2015-10-06', 'Aktif', 6, NULL, NULL),
(3158192512, 4806, 'Mikayla Aziya Putri\r\n', 'P', 'islam', 'Sei Buluh\r\n', '2015-08-23', 'Aktif', 7, NULL, NULL),
(3158294054, 4769, 'Aqila Balqis Zahara\r\n', 'P', 'islam', 'Medan\r\n', '2015-01-09', 'Aktif', 8, NULL, NULL),
(3158967793, 4776, 'Azka Azfar Rabbani\r\n', 'L', 'islam', 'Medan\r\n', '2015-10-03', 'Aktif', 7, NULL, NULL),
(3159493429, 4774, 'Aulia Ramadani\r\n', 'P', 'islam', 'Medan\r\n', '2015-06-18', 'Aktif', 7, NULL, NULL),
(3159522129, 4804, 'M. Raffa Alfiansyah\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2015-03-08', 'Aktif', 7, NULL, NULL),
(3159635258, 4933, 'M. Malikal Mulki', 'L', 'islam', 'Medan', '2015-10-31', 'Aktif', 5, NULL, NULL),
(3159736593, 4821, 'Noval Febryansyah\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2015-02-01', 'Aktif', 7, NULL, NULL),
(3159754378, 4920, 'Hafiz Hardiansyah', 'L', 'islam', 'Medan', '2015-10-21', 'Aktif', 5, NULL, NULL),
(3159913172, 4867, 'Abdurrahim', 'L', 'islam', 'Medan', '2015-12-16', 'Aktif', 6, NULL, NULL),
(3160173958, 4965, 'Reyfa Nadia Putri', 'P', 'islam', 'Medan', '2016-12-05', 'Aktif', 5, NULL, NULL),
(3160279528, 4928, 'Jihan Amelia', 'P', 'islam', 'Laut Dendang', '2016-05-03', 'Aktif', 5, NULL, NULL),
(3160319072, 4887, 'Anindya Alesha Gunawan', 'P', 'islam', 'Pematang Johor', '2016-01-05', 'Aktif', 4, NULL, NULL),
(3160867576, 4948, 'Mutiara', 'P', 'islam', 'Medan', '2016-02-15', 'Aktif', 4, NULL, NULL),
(3160927987, 4960, 'Rafani Putri Salsabila', 'P', 'islam', 'Medan', '2016-08-11', 'Aktif', 5, NULL, NULL),
(3161344902, 4866, 'Abdil Rasya', 'L', 'islam', 'Sampali', '2016-04-08', 'Aktif', 4, NULL, NULL),
(3162118714, 4962, 'Rafi Adithya Al Khadapi', 'L', 'islam', 'Medan', '2016-02-17', 'Aktif', 4, NULL, NULL),
(3162739615, 4971, 'Sila Pirlia', 'P', 'islam', 'Desa Selamat', '2016-04-21', 'Aktif', 5, NULL, NULL),
(3163209567, 4879, 'Al Pandy Ramadhan', 'L', 'islam', 'Laut Dendang', '2016-06-28', 'Aktif', 6, NULL, NULL),
(3163425131, 4892, 'Arsyah Rama Putra', 'L', 'islam', 'Tembung', '2016-01-13', 'Aktif', 6, NULL, NULL),
(3163456167, 4923, 'Hildan Soleh Admaja', 'L', 'islam', 'Medan', '2016-01-22', 'Aktif', 5, NULL, NULL),
(3163561272, 4900, 'Bunga Ranjani', 'L', 'islam', 'Langkat', '2016-06-01', 'Aktif', 6, NULL, NULL),
(3163630437, 4890, 'Aqilla Al Adzra', 'P', 'islam', 'Sei Semayang', '2016-05-05', 'Aktif', 6, NULL, NULL),
(3163904536, 4930, 'Kanasya Ayu Dia', 'P', 'islam', 'Laut Dendang', '2016-09-05', 'Aktif', 5, NULL, NULL),
(3164216743, 4913, 'Fadhli Kurniawan', 'L', 'islam', 'Medan', '2016-08-25', 'Aktif', 6, NULL, NULL),
(3164874840, 4937, 'Mhd. Rizky Ananda', 'L', 'islam', 'Medan', '2016-03-05', 'Aktif', 4, NULL, NULL),
(3164892372, 4981, 'Zulfan Azhar Raihan', 'L', 'islam', 'Laut Dendang', '2016-04-06', 'Aktif', 4, NULL, NULL),
(3164972877, 4894, 'Aurel Natasya', 'P', 'islam', 'Medan', '2016-01-06', 'Aktif', 4, NULL, NULL),
(3165037756, 4938, 'Mikayla Rastya', 'P', 'islam', 'Medan', '2016-03-02', 'Aktif', 5, NULL, NULL),
(3165365349, 4936, 'Mhd. Isa Prayoga', 'L', 'islam', 'Bandar Khalipah', '2014-08-11', 'Aktif', 5, NULL, NULL),
(3165570621, 4869, 'Abqari Runako', 'L', 'islam', 'Medan', '2016-04-27', 'Aktif', 5, NULL, NULL),
(3165780656, 4974, 'Uswatun Hasana', 'P', 'islam', 'Medan', '2016-03-15', 'Aktif', 4, NULL, NULL),
(3165855697, 4888, 'Annisa Sri Jingga', 'P', 'islam', 'Langsa', '2016-01-10', 'Aktif', 4, NULL, NULL),
(3166017319, 4972, 'Syahilla Az Zaheerah', 'P', 'islam', 'Medan', '2016-06-26', 'Aktif', 4, NULL, NULL),
(3166067636, 4927, 'Januar Revaldi', 'L', 'islam', 'Medan Estate', '2016-01-20', 'Aktif', 4, NULL, NULL),
(3166180093, 4967, 'Rifka Ramadani Nasution', 'P', 'islam', 'Medan', '2016-06-17', 'Aktif', 5, NULL, NULL),
(3166186576, 4939, 'Muhammad Al Fatih', 'L', 'islam', 'Bandar Klippa', '2016-04-06', 'Aktif', 4, NULL, NULL),
(3166424584, 4931, 'Keysa Zahra', 'P', 'islam', 'Laut Dendang', '2016-02-19', 'Aktif', 4, NULL, NULL),
(3166869418, 4910, 'Diwa Ramdahan', 'L', '', 'Medan', '2016-06-14', 'Aktif', 6, NULL, NULL),
(3167047726, 4940, 'Muhammad Alif Randika', 'L', 'islam', 'Medan', '2016-01-04', 'Aktif', 5, NULL, NULL),
(3167070238, 4935, 'M. Rizky Syahputra', 'L', 'islam', 'Laut Dendang', '2016-02-03', 'Aktif', 4, NULL, NULL),
(3167128995, 4870, 'Abri Syam Rainan Lubis', 'L', 'islam', 'Laut Dendang', '2016-04-15', 'Aktif', 5, NULL, NULL),
(3167174657, 4891, 'Arinka Jhui', 'P', 'islam', 'Sambirejo Tanjung', '2016-01-01', 'Aktif', 6, NULL, NULL),
(3167599223, 4878, 'Akila Firzanah Ritonga', 'P', 'islam', 'Pelalawan', '2016-03-01', 'Aktif', 5, NULL, NULL),
(3167616978, 4945, 'Muhammad Rafa Anggara', 'L', 'islam', 'Medan', '2016-05-30', 'Aktif', 4, NULL, NULL),
(3167941589, 4889, 'Aqila Syahirah Rafifah', 'P', 'islam', 'Medan', '2016-03-18', 'Aktif', 5, NULL, NULL),
(3168646248, 4970, 'Sandrin Almira', 'P', 'islam', 'Medan', '2016-08-16', 'Aktif', 5, NULL, NULL),
(3168671924, 4915, 'Fiona Adelia\r\n', 'P', 'islam', 'Medan\r\n', '2016-04-11', 'Aktif', 4, NULL, NULL),
(3169184904, 4973, 'Syahira Aulia Putri', 'P', 'islam', 'Bandar Setia', '2016-03-30', 'Aktif', 5, NULL, NULL),
(3169812626, 4897, 'Azril Athafariz Damanik', 'L', 'islam', 'Laut Dendang', '2016-06-07', 'Aktif', 4, NULL, NULL),
(3169862566, 4916, 'Gibran Arzanka Ramadhan', 'L', 'islam', 'Medan\r\n', '2016-06-10', 'Aktif', 4, NULL, NULL);

--
-- Triggers `tbl_siswas`
--
DELIMITER $$
CREATE TRIGGER `delete_siswa` BEFORE DELETE ON `tbl_siswas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_siswas 
		(aksi, nipd_lama, nisn_lama, nama_siswa_lama, jk_siswa_lama, agama_siswa_lama, tempat_lahir_lama, tanggal_lahir_lama, status_siswa_lama, id_kelas_lama, deleted_at)
	VALUES
		('Update', OLD.nipd, OLD.nisn, OLD.nama_siswa, OLD.jk_siswa, OLD.agama_siswa, OLD.tempat_lahir, OLD.tanggal_lahir, OLD.status_siswa, OLD.id_kelas, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_siswa` AFTER INSERT ON `tbl_siswas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_siswas 
		(aksi, nipd_baru, nisn_baru, nama_siswa_baru, jk_siswa_baru, agama_siswa_baru, tempat_lahir_baru, tanggal_lahir_baru, status_siswa_baru, id_kelas_baru, created_at)
	VALUES
		('Insert', NEW.nipd, NEW.nisn, NEW.nama_siswa, NEW.jk_siswa, NEW.agama_siswa, NEW.tempat_lahir, NEW.tanggal_lahir, NEW.status_siswa, NEW.id_kelas, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_siswa` AFTER UPDATE ON `tbl_siswas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_siswas 
		(aksi, nipd_lama, nipd_baru, nisn_lama, nisn_baru, nama_siswa_lama, nama_siswa_baru, jk_siswa_lama, jk_siswa_baru, agama_siswa_lama, agama_siswa_baru, tempat_lahir_baru, tempat_lahir_lama, tanggal_lahir_lama, tanggal_lahir_baru, status_siswa_lama, status_siswa_baru, id_kelas_lama, id_kelas_baru, updated_at)
	VALUES
		('Update', OLD.nipd, NEW.nipd, OLD.nisn, NEW.nisn, OLD.nama_siswa, NEW.nama_siswa, OLD.jk_siswa, NEW.jk_siswa, OLD.agama_siswa, NEW.agama_siswa, OLD.tempat_lahir, NEW.tempat_lahir, OLD.tanggal_lahir, NEW.tanggal_lahir, OLD.status_siswa, NEW.status_siswa, OLD.id_kelas, NEW.id_kelas, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_wali_siswas`
--

CREATE TABLE `tbl_wali_siswas` (
  `id_wali` int(10) UNSIGNED NOT NULL,
  `nisn` bigint(20) UNSIGNED NOT NULL,
  `jenis_wali` enum('Ayah','Ibu','Wali','') NOT NULL,
  `nama_wali` varchar(255) NOT NULL,
  `jenjang_pendidikan` enum('Tidak Sekolah','SD / Sederajat','SMP / Sederajat','SMA / Sederajat','D1 / Sederajat','D2 / Sederajat','D3 / Sederajat','D4 / Sederajat','S1 / Sederajat','S2 / Sederajat','S3 / Sederajat') NOT NULL,
  `pekerjaan` varchar(255) NOT NULL,
  `penghasilan` enum('Tidak Berpenghasilan','Kurang dari Rp 500.000','Rp 500.000 - Rp 999.999','Rp 1.000.000 - Rp 1.999.999','Rp 2.000.000 - Rp 4.999.999','Rp 5.000.000 - Rp 7.999.999') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_wali_siswas`
--

INSERT INTO `tbl_wali_siswas` (`id_wali`, `nisn`, `jenis_wali`, `nama_wali`, `jenjang_pendidikan`, `pekerjaan`, `penghasilan`) VALUES
(1, 139760118, 'Ayah', 'Subaktiar, ST\r\n', 'S1 / Sederajat', 'Karyawan Swasta\r\n', 'Rp 2.000.000 - Rp 4.999.999'),
(2, 3125405642, 'Ayah', 'Sayono\r\n', 'SMP / Sederajat', 'Buruh\r\n', 'Rp 1.000.000 - Rp 1.999.999'),
(3, 3121535615, 'Ayah', 'Rihad Ardi\r\n', 'SMA / Sederajat', 'Buruh\r\n', 'Rp 1.000.000 - Rp 1.999.999'),
(4, 3112936976, 'Ayah', 'Diki Susanti\r\n', 'SMP / Sederajat', 'Lainnya\r\n', 'Kurang dari Rp 500.000'),
(5, 3123605240, 'Ayah', 'Saman\r\n', 'SMP / Sederajat', 'Buruh\r\n', 'Rp 1.000.000 - Rp 1.999.999'),
(6, 3115923861, 'Ayah', 'Nuralam\r\n', 'SD / Sederajat', 'Buruh\r\n', 'Rp 1.000.000 - Rp 1.999.999'),
(7, 142522058, 'Ayah', 'Hendri\r\n', 'SMA / Sederajat', 'Karyawan Swasta\r\n', 'Rp 1.000.000 - Rp 1.999.999'),
(8, 143098302, 'Ayah', 'Suyatno\r\n', 'SMP / Sederajat', 'Karyawan Swasta\r\n', 'Rp 1.000.000 - Rp 1.999.999'),
(9, 3151860080, 'Ayah', 'Erika Saputra\r\n', 'SMP / Sederajat', 'Wiraswasta\r\n', 'Rp 2.000.000 - Rp 4.999.999'),
(10, 3141626572, 'Ayah', 'Syarif Batubara\r\n', 'SMA / Sederajat', 'PNS/TNI/Polri\r\n', 'Rp 2.000.000 - Rp 4.999.999'),
(11, 3145678900, 'Ayah', 'Muhammad Salim\r\n', 'SMA / Sederajat', 'Wiraswasta\r\n', 'Rp 1.000.000 - Rp 1.999.999'),
(12, 3149648071, 'Ayah', 'Andri Sundana\r\n', 'SMA / Sederajat', 'Karyawan Swasta\r\n', 'Rp 1.000.000 - Rp 1.999.999'),
(13, 3150108687, 'Ayah', 'Wandi\r\n', 'SMA / Sederajat', 'Karyawan Swasta\r\n', 'Rp 2.000.000 - Rp 4.999.999'),
(14, 3150283414, 'Ayah', 'M. Ridwan\r\n', 'SMA / Sederajat', 'Buruh\r\n', 'Rp 1.000.000 - Rp 1.999.999'),
(15, 3151898759, 'Ayah', 'Yandi Gunawan\r\n', 'SMA / Sederajat', 'Wiraswasta\r\n', 'Rp 2.000.000 - Rp 4.999.999');

--
-- Triggers `tbl_wali_siswas`
--
DELIMITER $$
CREATE TRIGGER `delete_wali_siswa` BEFORE DELETE ON `tbl_wali_siswas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_wali_siswas
    	(aksi, nisn_lama, jenis_wali_lama, nama_wali_lama, jenjang_pendidikan_lama, pekerjaan_lama, penghasilan_lama, deleted_at)
	VALUES
    	('Delete', OLD.nisn, OLD.jenis_wali, OLD.nama_wali, OLD.jenjang_pendidikan, OLD.pekerjaan, OLD.penghasilan, NOW());
        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_wali_siswa` AFTER INSERT ON `tbl_wali_siswas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_wali_siswas
    	(aksi, nisn_baru, jenis_wali_baru, nama_wali_baru, jenjang_pendidikan_baru, pekerjaan_baru, penghasilan_baru, created_at)
	VALUES
    	('Insert', NEW.nisn, NEW.jenis_wali, NEW.nama_wali, NEW.jenjang_pendidikan, NEW.pekerjaan, NEW.penghasilan, NOW());
        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_wali_siswa` AFTER UPDATE ON `tbl_wali_siswas` FOR EACH ROW BEGIN
	INSERT INTO log_tbl_wali_siswas
    	(aksi, nisn_lama, nisn_baru, jenis_wali_lama, jenis_wali_baru, nama_wali_lama, nama_wali_baru, jenjang_pendidikan_lama, jenjang_pendidikan_baru, pekerjaan_lama, pekerjaan_baru, penghasilan_lama, penghasilan_baru, updated_at)
	VALUES
    	('Update', OLD.nisn, NEW.nisn, OLD.jenis_wali, NEW.jenis_wali, OLD.nama_wali, NEW.nama_wali, OLD.jenjang_pendidikan, NEW.jenjang_pendidikan, OLD.pekerjaan, NEW.pekerjaan, OLD.penghasilan, NEW.penghasilan, NOW());
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure for view `ekstrakurikulersiswa`
--
DROP TABLE IF EXISTS `ekstrakurikulersiswa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ekstrakurikulersiswa`  AS SELECT `e`.`nama_ekstrakurikuler` AS `nama_ekstrakurikuler`, `s`.`nama_siswa` AS `nama_siswa` FROM ((`tbl_ekstrakurikuler_siswas` `es` join `tbl_ekstrakurikulers` `e` on((`es`.`id_ekskul` = `e`.`id_ekskul`))) join `tbl_siswas` `s` on((`s`.`nisn` = `es`.`nisn_siswa`))) ;

-- --------------------------------------------------------

--
-- Structure for view `mapeldanpengajar`
--
DROP TABLE IF EXISTS `mapeldanpengajar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mapeldanpengajar`  AS SELECT `bs`.`nama_mapel` AS `nama_mapel`, `g`.`nama_guru` AS `nama_guru` FROM ((`tbl_mapel_gurus` `mg` join `tbl_gurus` `g` on((`mg`.`id_guru` = `g`.`id_guru`))) join `tbl_bidang_studis` `bs` on((`mg`.`id_mapel` = `bs`.`id_mapel`))) ;

-- --------------------------------------------------------

--
-- Structure for view `rosterguru`
--
DROP TABLE IF EXISTS `rosterguru`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rosterguru`  AS SELECT `r`.`hari` AS `hari`, `g`.`nama_guru` AS `nama_guru`, `bs`.`nama_mapel` AS `nama_mapel`, `r`.`waktu_mulai` AS `waktu_mulai`, `r`.`waktu_akhir` AS `waktu_akhir`, `r`.`kelas` AS `kelas` FROM (((`tbl_rosters` `r` join `tbl_mapel_gurus` `mg` on((`r`.`mapel_guru` = `mg`.`id`))) join `tbl_bidang_studis` `bs` on((`mg`.`id_mapel` = `bs`.`id_mapel`))) join `tbl_gurus` `g` on((`mg`.`id_guru` = `g`.`id_guru`))) ;

-- --------------------------------------------------------

--
-- Structure for view `rosterkelas`
--
DROP TABLE IF EXISTS `rosterkelas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rosterkelas`  AS SELECT `bs`.`nama_mapel` AS `nama_mapel`, `r`.`waktu_mulai` AS `waktu_mulai`, `r`.`waktu_akhir` AS `waktu_akhir`, `r`.`hari` AS `hari`, `k`.`nama` AS `nama_kelas` FROM (((`tbl_rosters` `r` join `tbl_mapel_gurus` `mg` on((`r`.`mapel_guru` = `mg`.`id`))) join `tbl_bidang_studis` `bs` on((`mg`.`id_mapel` = `bs`.`id_mapel`))) join `tbl_kelas` `k` on((`k`.`id_kelas` = `r`.`kelas`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `log_tbl_akuns`
--
ALTER TABLE `log_tbl_akuns`
  ADD PRIMARY KEY (`id_akun`);

--
-- Indexes for table `log_tbl_beritas`
--
ALTER TABLE `log_tbl_beritas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_tbl_ekstrakurikulers`
--
ALTER TABLE `log_tbl_ekstrakurikulers`
  ADD PRIMARY KEY (`id_ekskul`);

--
-- Indexes for table `log_tbl_ekstrakurikuler_siswas`
--
ALTER TABLE `log_tbl_ekstrakurikuler_siswas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_tbl_gurus`
--
ALTER TABLE `log_tbl_gurus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_tbl_kelas`
--
ALTER TABLE `log_tbl_kelas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_tbl_mapel_gurus`
--
ALTER TABLE `log_tbl_mapel_gurus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_tbl_pegawais`
--
ALTER TABLE `log_tbl_pegawais`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_tbl_prestasis`
--
ALTER TABLE `log_tbl_prestasis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_tbl_rosters`
--
ALTER TABLE `log_tbl_rosters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_tbl_siswas`
--
ALTER TABLE `log_tbl_siswas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_tbl_wali_siswas`
--
ALTER TABLE `log_tbl_wali_siswas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_akuns`
--
ALTER TABLE `tbl_akuns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_beritas`
--
ALTER TABLE `tbl_beritas`
  ADD PRIMARY KEY (`id_berita`),
  ADD KEY `fk_akun_berita` (`id_akun`);

--
-- Indexes for table `tbl_bidang_studis`
--
ALTER TABLE `tbl_bidang_studis`
  ADD PRIMARY KEY (`id_mapel`);

--
-- Indexes for table `tbl_ekstrakurikulers`
--
ALTER TABLE `tbl_ekstrakurikulers`
  ADD PRIMARY KEY (`id_ekskul`);

--
-- Indexes for table `tbl_ekstrakurikuler_siswas`
--
ALTER TABLE `tbl_ekstrakurikuler_siswas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ekskul` (`id_ekskul`),
  ADD KEY `fk_ekskul_siswa` (`nisn_siswa`);

--
-- Indexes for table `tbl_fasilitas`
--
ALTER TABLE `tbl_fasilitas`
  ADD PRIMARY KEY (`id_fasilitas`);

--
-- Indexes for table `tbl_gurus`
--
ALTER TABLE `tbl_gurus`
  ADD PRIMARY KEY (`id_guru`);

--
-- Indexes for table `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  ADD PRIMARY KEY (`id_kelas`),
  ADD KEY `fk_kelas_guru` (`wali_kelas`);

--
-- Indexes for table `tbl_mapel_gurus`
--
ALTER TABLE `tbl_mapel_gurus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_guru_walikelas` (`id_guru`),
  ADD KEY `fk_mapel_walikelas` (`id_mapel`);

--
-- Indexes for table `tbl_nilais`
--
ALTER TABLE `tbl_nilais`
  ADD PRIMARY KEY (`id_nilai`),
  ADD KEY `fk_nisn_nilai` (`nisn_siswa`),
  ADD KEY `fk_mapel_nilai` (`id_mapel`),
  ADD KEY `fk_guru_nilai` (`id_guru`);

--
-- Indexes for table `tbl_pegawais`
--
ALTER TABLE `tbl_pegawais`
  ADD PRIMARY KEY (`id_pegawai`);

--
-- Indexes for table `tbl_prestasis`
--
ALTER TABLE `tbl_prestasis`
  ADD PRIMARY KEY (`id_prestasi`);

--
-- Indexes for table `tbl_rosters`
--
ALTER TABLE `tbl_rosters`
  ADD PRIMARY KEY (`roster_id`),
  ADD KEY `fk_mapel_guru_roster` (`mapel_guru`),
  ADD KEY `fk_kelas_roster` (`kelas`);

--
-- Indexes for table `tbl_siswas`
--
ALTER TABLE `tbl_siswas`
  ADD PRIMARY KEY (`nisn`),
  ADD UNIQUE KEY `nipd_unique` (`nipd`) USING BTREE,
  ADD KEY `fk_kelas_siswa` (`id_kelas`);

--
-- Indexes for table `tbl_wali_siswas`
--
ALTER TABLE `tbl_wali_siswas`
  ADD PRIMARY KEY (`id_wali`),
  ADD KEY `fk_wali_siswa` (`nisn`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `log_tbl_akuns`
--
ALTER TABLE `log_tbl_akuns`
  MODIFY `id_akun` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log_tbl_beritas`
--
ALTER TABLE `log_tbl_beritas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `log_tbl_ekstrakurikulers`
--
ALTER TABLE `log_tbl_ekstrakurikulers`
  MODIFY `id_ekskul` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `log_tbl_ekstrakurikuler_siswas`
--
ALTER TABLE `log_tbl_ekstrakurikuler_siswas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `log_tbl_gurus`
--
ALTER TABLE `log_tbl_gurus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `log_tbl_kelas`
--
ALTER TABLE `log_tbl_kelas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `log_tbl_mapel_gurus`
--
ALTER TABLE `log_tbl_mapel_gurus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `log_tbl_pegawais`
--
ALTER TABLE `log_tbl_pegawais`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `log_tbl_prestasis`
--
ALTER TABLE `log_tbl_prestasis`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `log_tbl_rosters`
--
ALTER TABLE `log_tbl_rosters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `log_tbl_siswas`
--
ALTER TABLE `log_tbl_siswas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `log_tbl_wali_siswas`
--
ALTER TABLE `log_tbl_wali_siswas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_akuns`
--
ALTER TABLE `tbl_akuns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_beritas`
--
ALTER TABLE `tbl_beritas`
  MODIFY `id_berita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tbl_bidang_studis`
--
ALTER TABLE `tbl_bidang_studis`
  MODIFY `id_mapel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tbl_ekstrakurikulers`
--
ALTER TABLE `tbl_ekstrakurikulers`
  MODIFY `id_ekskul` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_ekstrakurikuler_siswas`
--
ALTER TABLE `tbl_ekstrakurikuler_siswas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tbl_fasilitas`
--
ALTER TABLE `tbl_fasilitas`
  MODIFY `id_fasilitas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_gurus`
--
ALTER TABLE `tbl_gurus`
  MODIFY `id_guru` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  MODIFY `id_kelas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tbl_mapel_gurus`
--
ALTER TABLE `tbl_mapel_gurus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `tbl_nilais`
--
ALTER TABLE `tbl_nilais`
  MODIFY `id_nilai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_pegawais`
--
ALTER TABLE `tbl_pegawais`
  MODIFY `id_pegawai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_prestasis`
--
ALTER TABLE `tbl_prestasis`
  MODIFY `id_prestasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_rosters`
--
ALTER TABLE `tbl_rosters`
  MODIFY `roster_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `tbl_wali_siswas`
--
ALTER TABLE `tbl_wali_siswas`
  MODIFY `id_wali` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_beritas`
--
ALTER TABLE `tbl_beritas`
  ADD CONSTRAINT `fk_akun_beritas` FOREIGN KEY (`id_akun`) REFERENCES `tbl_akuns` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_ekstrakurikuler_siswas`
--
ALTER TABLE `tbl_ekstrakurikuler_siswas`
  ADD CONSTRAINT `fk_ekskul` FOREIGN KEY (`id_ekskul`) REFERENCES `tbl_ekstrakurikulers` (`id_ekskul`),
  ADD CONSTRAINT `fk_ekskul_siswa` FOREIGN KEY (`nisn_siswa`) REFERENCES `tbl_siswas` (`nisn`);

--
-- Constraints for table `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  ADD CONSTRAINT `fk_kelas_guru` FOREIGN KEY (`wali_kelas`) REFERENCES `tbl_gurus` (`id_guru`);

--
-- Constraints for table `tbl_mapel_gurus`
--
ALTER TABLE `tbl_mapel_gurus`
  ADD CONSTRAINT `fk_guru_walikelas` FOREIGN KEY (`id_guru`) REFERENCES `tbl_gurus` (`id_guru`),
  ADD CONSTRAINT `fk_mapel_walikelas` FOREIGN KEY (`id_mapel`) REFERENCES `tbl_bidang_studis` (`id_mapel`);

--
-- Constraints for table `tbl_nilais`
--
ALTER TABLE `tbl_nilais`
  ADD CONSTRAINT `fk_guru` FOREIGN KEY (`id_guru`) REFERENCES `tbl_gurus` (`id_guru`),
  ADD CONSTRAINT `fk_id_mapel` FOREIGN KEY (`id_mapel`) REFERENCES `tbl_bidang_studis` (`id_mapel`),
  ADD CONSTRAINT `fk_nisn_siswa` FOREIGN KEY (`nisn_siswa`) REFERENCES `tbl_siswas` (`nisn`);

--
-- Constraints for table `tbl_rosters`
--
ALTER TABLE `tbl_rosters`
  ADD CONSTRAINT `fk_kelas_roster` FOREIGN KEY (`kelas`) REFERENCES `tbl_kelas` (`id_kelas`),
  ADD CONSTRAINT `fk_mapel_guru_roster` FOREIGN KEY (`mapel_guru`) REFERENCES `tbl_mapel_gurus` (`id`);

--
-- Constraints for table `tbl_siswas`
--
ALTER TABLE `tbl_siswas`
  ADD CONSTRAINT `fk_kelas_siswa` FOREIGN KEY (`id_kelas`) REFERENCES `tbl_kelas` (`id_kelas`);

--
-- Constraints for table `tbl_wali_siswas`
--
ALTER TABLE `tbl_wali_siswas`
  ADD CONSTRAINT `fk_wali_siswa` FOREIGN KEY (`nisn`) REFERENCES `tbl_siswas` (`nisn`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
