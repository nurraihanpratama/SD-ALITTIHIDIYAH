-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 27, 2023 at 10:32 AM
-- Server version: 5.7.33
-- PHP Version: 7.4.19

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
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(37, 'Delete', 'NISA SABYAN', NULL, '', NULL, 'Aktif', 'Aktif', '2023-12-21 01:27:36', '2023-12-21 01:27:36', '2023-12-21 01:27:36'),
(38, 'Update', 'Linda Siti Zulaikha, S.Pd', 'Linda Siti Zulaikha', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:35:03', '2023-12-26 08:35:03', '2023-12-26 08:35:03'),
(39, 'Update', 'Linda Siti Zulaikha', 'Linda Siti Zulaikha', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:35:08', '2023-12-26 08:35:08', '2023-12-26 08:35:08'),
(40, 'Update', 'Ali Rahman, S.Pd.I', 'Ali Rahman, S.Pd.I', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:35:17', '2023-12-26 08:35:17', '2023-12-26 08:35:17'),
(41, 'Update', 'Ali Rahman, S.Pd.I', 'Ali Rahman', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:35:22', '2023-12-26 08:35:22', '2023-12-26 08:35:22'),
(42, 'Update', 'Chairul Azmi Lubis, S.Pd', 'Chairul Azmi Lubis, S.Pd', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:35:29', '2023-12-26 08:35:29', '2023-12-26 08:35:29'),
(43, 'Update', 'Riri Andrian, S.Pd', 'Riri Andrian, S.Pd', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:35:31', '2023-12-26 08:35:31', '2023-12-26 08:35:31'),
(44, 'Update', 'Riri Andrian, S.Pd', 'Riri Andrian', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:35:35', '2023-12-26 08:35:35', '2023-12-26 08:35:35'),
(45, 'Update', 'Chairul Azmi Lubis, S.Pd', 'Chairul Azmi Lubis', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:35:39', '2023-12-26 08:35:39', '2023-12-26 08:35:39'),
(46, 'Update', 'Sri Wedari, S.Ag', 'Sri Wedari', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:35:43', '2023-12-26 08:35:43', '2023-12-26 08:35:43'),
(47, 'Update', 'Sri Wedari', 'Sri Wedari', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:35:46', '2023-12-26 08:35:46', '2023-12-26 08:35:46'),
(48, 'Update', 'Nurlia Ayuni, S.Pd', 'Nurlia Ayuni, S.Pd', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:35:49', '2023-12-26 08:35:49', '2023-12-26 08:35:49'),
(49, 'Update', 'Mariani, S.Pd.I', 'Mariani, S.Pd.I', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:35:53', '2023-12-26 08:35:53', '2023-12-26 08:35:53'),
(50, 'Update', 'Mariani, S.Pd.I', 'Mariani', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:36:00', '2023-12-26 08:36:00', '2023-12-26 08:36:00'),
(51, 'Update', 'Nurlia Ayuni, S.Pd', 'Nurlia Ayuni', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:36:03', '2023-12-26 08:36:03', '2023-12-26 08:36:03'),
(52, 'Update', 'Nahfazul Fauziah Harahap, S.Pd', 'Nahfazul Fauziah Harahap, S.Pd', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:36:06', '2023-12-26 08:36:06', '2023-12-26 08:36:06'),
(53, 'Update', 'Nahfazul Fauziah Harahap, S.Pd', 'Nahfazul Fauziah Harahap', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:36:11', '2023-12-26 08:36:11', '2023-12-26 08:36:11'),
(54, 'Update', 'Nurlia Ayuni', 'Nurlia Ayuni', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:36:18', '2023-12-26 08:36:18', '2023-12-26 08:36:18'),
(55, 'Update', 'Salmah, S.Ag', 'Salmah, S.Ag', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:36:24', '2023-12-26 08:36:24', '2023-12-26 08:36:24'),
(56, 'Update', 'Susilawati, S.Ag', 'Susilawati, S.Ag', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:36:29', '2023-12-26 08:36:29', '2023-12-26 08:36:29'),
(57, 'Update', 'Laily Ramadhani, S.Pd, M.Ak', 'Laily Ramadhani, S.Pd, M.Ak', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:36:58', '2023-12-26 08:36:58', '2023-12-26 08:36:58'),
(58, 'Update', 'Susilawati, S.Ag', 'Susilawati', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:04', '2023-12-26 08:37:04', '2023-12-26 08:37:04'),
(59, 'Update', 'Salmah, S.Ag', 'Salmah', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:07', '2023-12-26 08:37:07', '2023-12-26 08:37:07'),
(60, 'Update', 'Laily Ramadhani, S.Pd, M.Ak', 'Laily Ramadhani', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:11', '2023-12-26 08:37:11', '2023-12-26 08:37:11'),
(61, 'Update', 'Nuranisa, S.Pd.I', 'Nuranisa', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:15', '2023-12-26 08:37:15', '2023-12-26 08:37:15'),
(62, 'Update', 'Rudi Ahmad, S.Pd.I', 'Rudi Ahmad', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:18', '2023-12-26 08:37:18', '2023-12-26 08:37:18'),
(63, 'Update', 'Seri Wahyuni, S.Pd.I', 'Seri Wahyuni', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:21', '2023-12-26 08:37:21', '2023-12-26 08:37:21'),
(64, 'Update', 'Masitah, S.Pd.I', 'Masitah', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:26', '2023-12-26 08:37:26', '2023-12-26 08:37:26'),
(65, 'Update', 'Qatrunnada, S.Pd.I', 'Qatrunnada', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:29', '2023-12-26 08:37:29', '2023-12-26 08:37:29'),
(66, 'Update', 'Nuranisa', 'Nuranisa', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:34', '2023-12-26 08:37:34', '2023-12-26 08:37:34'),
(67, 'Update', 'Rudi Ahmad', 'Rudi Ahmad', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:35', '2023-12-26 08:37:35', '2023-12-26 08:37:35'),
(68, 'Update', 'Seri Wahyuni', 'Seri Wahyuni', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:37', '2023-12-26 08:37:37', '2023-12-26 08:37:37'),
(69, 'Update', 'Masitah', 'Masitah', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:38', '2023-12-26 08:37:38', '2023-12-26 08:37:38'),
(70, 'Update', 'Qatrunnada', 'Qatrunnada', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:40', '2023-12-26 08:37:40', '2023-12-26 08:37:40'),
(71, 'Update', 'Nuranisa', 'Nuranisa', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:44', '2023-12-26 08:37:44', '2023-12-26 08:37:44'),
(72, 'Update', 'Rudi Ahmad', 'Rudi Ahmad', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:49', '2023-12-26 08:37:49', '2023-12-26 08:37:49'),
(73, 'Update', 'Seri Wahyuni', 'Seri Wahyuni', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:51', '2023-12-26 08:37:51', '2023-12-26 08:37:51'),
(74, 'Update', 'Masitah', 'Masitah', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:53', '2023-12-26 08:37:53', '2023-12-26 08:37:53'),
(75, 'Update', 'Qatrunnada', 'Qatrunnada', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:37:55', '2023-12-26 08:37:55', '2023-12-26 08:37:55'),
(76, 'Update', 'Maimunah. Bb, S.Sos', 'Maimunah. Bb', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:38:07', '2023-12-26 08:38:07', '2023-12-26 08:38:07'),
(77, 'Update', 'Maimunah. Bb', 'Maimunah. Bb', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:38:09', '2023-12-26 08:38:09', '2023-12-26 08:38:09'),
(78, 'Update', 'Nuraini, SE', 'Nuraini, SE', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:38:16', '2023-12-26 08:38:16', '2023-12-26 08:38:16'),
(79, 'Update', 'Nuraini, SE', 'Nuraini', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-26 08:38:20', '2023-12-26 08:38:20', '2023-12-26 08:38:20'),
(80, 'Update', 'Linda Siti Zulaikha', 'Linda Siti Zulaikha', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:01:03', '2023-12-27 07:01:03', '2023-12-27 07:01:03'),
(81, 'Update', 'Siti Warohmah', 'Siti Warohmah', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:09', '2023-12-27 07:04:09', '2023-12-27 07:04:09'),
(82, 'Update', 'Andi Putra Batubara', 'Andi Putra Batubara', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:09', '2023-12-27 07:04:09', '2023-12-27 07:04:09'),
(83, 'Update', 'Ali Rahman', 'Ali Rahman', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:09', '2023-12-27 07:04:09', '2023-12-27 07:04:09'),
(84, 'Update', 'Chairul Azmi Lubis', 'Chairul Azmi Lubis', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:10', '2023-12-27 07:04:10', '2023-12-27 07:04:10'),
(85, 'Update', 'Riri Andrian', 'Riri Andrian', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:10', '2023-12-27 07:04:10', '2023-12-27 07:04:10'),
(86, 'Update', 'Sri Wedari', 'Sri Wedari', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:10', '2023-12-27 07:04:10', '2023-12-27 07:04:10'),
(87, 'Update', 'Nurlia Ayuni', 'Nurlia Ayuni', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:11', '2023-12-27 07:04:11', '2023-12-27 07:04:11'),
(88, 'Update', 'Mariani', 'Mariani', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:11', '2023-12-27 07:04:11', '2023-12-27 07:04:11'),
(89, 'Update', 'Nahfazul Fauziah Harahap', 'Nahfazul Fauziah Harahap', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:11', '2023-12-27 07:04:11', '2023-12-27 07:04:11'),
(90, 'Update', 'Salmah', 'Salmah', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:11', '2023-12-27 07:04:11', '2023-12-27 07:04:11'),
(91, 'Update', 'Susilawati', 'Susilawati', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:12', '2023-12-27 07:04:12', '2023-12-27 07:04:12'),
(92, 'Update', 'Laily Ramadhani', 'Laily Ramadhani', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:12', '2023-12-27 07:04:12', '2023-12-27 07:04:12'),
(93, 'Update', 'Nuranisa', 'Nuranisa', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:12', '2023-12-27 07:04:12', '2023-12-27 07:04:12'),
(94, 'Update', 'Rudi Ahmad', 'Rudi Ahmad', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:12', '2023-12-27 07:04:12', '2023-12-27 07:04:12'),
(95, 'Update', 'Seri Wahyuni', 'Seri Wahyuni', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:13', '2023-12-27 07:04:13', '2023-12-27 07:04:13'),
(96, 'Update', 'Masitah', 'Masitah', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:13', '2023-12-27 07:04:13', '2023-12-27 07:04:13'),
(97, 'Update', 'Qatrunnada', 'Qatrunnada', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:13', '2023-12-27 07:04:13', '2023-12-27 07:04:13'),
(98, 'Update', 'Maimunah. Bb', 'Maimunah. Bb', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:14', '2023-12-27 07:04:14', '2023-12-27 07:04:14'),
(99, 'Update', 'Nuraini', 'Nuraini', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:14', '2023-12-27 07:04:14', '2023-12-27 07:04:14'),
(100, 'Update', 'Alvy Hayati Nur', 'Alvy Hayati Nur', 'Non-PNS', 'Non-PNS', 'Aktif', 'Aktif', '2023-12-27 07:04:14', '2023-12-27 07:04:14', '2023-12-27 07:04:14');

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
(11, 'Delete', 'Testt', NULL, 1, NULL, '2023-12-21 01:18:40', '2023-12-21 01:18:40', '2023-12-21 01:18:40'),
(12, 'Update', 'I-A', 'I-A', 7, 7, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(13, 'Update', 'I-B', 'I-B', 9, 9, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(14, 'Update', 'I-C', 'I-C', 17, 17, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(15, 'Update', 'II-A', 'II-A', 10, 10, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(16, 'Update', 'II-B', 'II-B', 9, 9, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(17, 'Update', 'II-C', 'II-C', 11, 11, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(18, 'Update', 'III-A', 'III-A', 8, 8, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(19, 'Update', 'III-B', 'III-B', 12, 12, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(20, 'Update', 'IV-A', 'IV-A', 21, 21, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(21, 'Update', 'IV-B', 'IV-B', 13, 13, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(22, 'Update', 'IV-C', 'IV-C', 15, 15, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(23, 'Update', 'V-A', 'V-A', 14, 14, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(24, 'Update', 'V-B', 'V-B', 15, 15, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(25, 'Update', 'V-C', 'V-C', 19, 19, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(26, 'Update', 'VI-A', 'VI-A', 18, 18, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(27, 'Update', 'VI-B', 'VI-B', 20, 20, '2023-12-26 10:08:16', '2023-12-26 10:08:16', '2023-12-26 10:08:16'),
(28, 'Update', 'II-A', 'II-A', 10, 10, '2023-12-26 10:10:41', '2023-12-26 10:10:41', '2023-12-26 10:10:41'),
(29, 'Update', 'II-B', 'II-B', 9, 9, '2023-12-26 10:10:45', '2023-12-26 10:10:45', '2023-12-26 10:10:45'),
(30, 'Update', 'II-C', 'II-C', 11, 11, '2023-12-26 10:10:48', '2023-12-26 10:10:48', '2023-12-26 10:10:48'),
(31, 'Update', 'III-A', 'III-A', 8, 8, '2023-12-26 10:10:50', '2023-12-26 10:10:50', '2023-12-26 10:10:50'),
(32, 'Update', 'III-B', 'III-B', 12, 12, '2023-12-26 10:10:53', '2023-12-26 10:10:53', '2023-12-26 10:10:53'),
(33, 'Update', 'IV-A', 'IV-A', 21, 21, '2023-12-26 10:10:57', '2023-12-26 10:10:57', '2023-12-26 10:10:57'),
(34, 'Update', 'IV-B', 'IV-B', 13, 13, '2023-12-26 10:10:59', '2023-12-26 10:10:59', '2023-12-26 10:10:59'),
(35, 'Update', 'IV-C', 'IV-C', 15, 15, '2023-12-26 10:11:02', '2023-12-26 10:11:02', '2023-12-26 10:11:02'),
(36, 'Update', 'V-A', 'V-A', 14, 14, '2023-12-26 10:11:05', '2023-12-26 10:11:05', '2023-12-26 10:11:05'),
(37, 'Update', 'V-B', 'V-B', 15, 15, '2023-12-26 10:11:08', '2023-12-26 10:11:08', '2023-12-26 10:11:08'),
(38, 'Update', 'V-C', 'V-C', 19, 19, '2023-12-26 10:11:11', '2023-12-26 10:11:11', '2023-12-26 10:11:11'),
(39, 'Update', 'VI-A', 'VI-A', 18, 18, '2023-12-26 10:11:14', '2023-12-26 10:11:14', '2023-12-26 10:11:14'),
(40, 'Update', 'VI-B', 'VI-B', 20, 20, '2023-12-26 10:11:17', '2023-12-26 10:11:17', '2023-12-26 10:11:17');

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
(17, 'Update', 123, NULL, '123', NULL, 'Incidunt de', NULL, 'L', NULL, '', NULL, 'Omnis et a p', NULL, '1979-06-28', NULL, 'Aktif', NULL, 8, NULL, '2023-12-21 01:14:20', '2023-12-21 01:14:20', '2023-12-21 01:14:20'),
(18, 'Update', 999999, 999999, '999999', '999999', 'adam', 'adam', 'L', 'L', 'Islam', 'Islam', 'Batam', 'Batam', '2002-12-04', '2002-12-04', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:21', '2023-12-27 07:45:21', '2023-12-27 07:45:21'),
(19, 'Update', 4412, 4412, '111172557', '111172557', 'Dilla Mahera\r\n', 'Dilla Mahera\r\n', 'P', 'P', 'Islam', 'Islam', 'sigli\r\n', 'sigli\r\n', '2011-06-21', '2011-06-21', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:22', '2023-12-27 07:45:22', '2023-12-27 07:45:22'),
(20, 'Update', 4464, 4464, '112403313', '112403313', 'Reza Dwi Andika', 'Reza Dwi Andika', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2011-12-31', '2011-12-31', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:22', '2023-12-27 07:45:22', '2023-12-27 07:45:22'),
(21, 'Update', 4402, 4402, '112415392', '112415392', 'Alief Frandika', 'Alief Frandika', 'L', 'L', 'Islam', 'Islam', 'kolam', 'kolam', '2011-12-06', '2011-12-06', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:22', '2023-12-27 07:45:22', '2023-12-27 07:45:22'),
(22, 'Update', 4465, 4465, '112464967', '112464967', 'Ridhuan', 'Ridhuan', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2011-12-27', '2011-12-27', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:22', '2023-12-27 07:45:22', '2023-12-27 07:45:22'),
(23, 'Update', 4427, 4427, '112919751', '112919751', 'KAMAL MAULANA HARAHAP\r\n', 'KAMAL MAULANA HARAHAP\r\n', 'L', 'L', 'Islam', 'Islam', 'BANDAR KHALIPAH\r\n', 'BANDAR KHALIPAH\r\n', '2011-05-05', '2011-05-05', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:23', '2023-12-27 07:45:23', '2023-12-27 07:45:23'),
(24, 'Update', 4414, 4414, '113327378', '113327378', 'Dini Anggraini', 'Dini Anggraini', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2011-11-26', '2011-11-26', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:23', '2023-12-27 07:45:23', '2023-12-27 07:45:23'),
(25, 'Update', 4469, 4469, '116826680', '116826680', 'Risky Aditia Nugroho', 'Risky Aditia Nugroho', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2011-05-26', '2011-05-26', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:23', '2023-12-27 07:45:23', '2023-12-27 07:45:23'),
(26, 'Update', 4420, 4420, '117461542', '117461542', 'Fadillah Ahmad', 'Fadillah Ahmad', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2011-12-01', '2011-12-01', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:24', '2023-12-27 07:45:24', '2023-12-27 07:45:24'),
(27, 'Update', 4397, 4397, '118969993', '118969993', 'Adetya\r\n', 'Adetya\r\n', 'L', 'L', 'Islam', 'Islam', 'medan\r\n', 'medan\r\n', '2011-08-04', '2011-08-04', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:24', '2023-12-27 07:45:24', '2023-12-27 07:45:24'),
(28, 'Update', 4999, 4999, '121086551', '121086551', 'KINANTI PUTRI DWI MAULANA\r\n', 'KINANTI PUTRI DWI MAULANA\r\n', 'P', 'P', 'Islam', 'Islam', 'MEDAN\r\n', 'MEDAN\r\n', '2012-11-29', '2012-11-29', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:24', '2023-12-27 07:45:24', '2023-12-27 07:45:24'),
(29, 'Update', 4425, 4425, '121302996', '121302996', 'Irvan Khadavi', 'Irvan Khadavi', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2012-10-09', '2012-10-09', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:25', '2023-12-27 07:45:25', '2023-12-27 07:45:25'),
(30, 'Update', 4400, 4400, '121427032', '121427032', 'Alfiani Nowilia Safitri', 'Alfiani Nowilia Safitri', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2012-11-06', '2012-11-06', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:25', '2023-12-27 07:45:25', '2023-12-27 07:45:25'),
(31, 'Update', 4423, 4423, '121647881', '121647881', 'Harnita Nadya Auliyah\r\n', 'Harnita Nadya Auliyah\r\n', 'P', 'P', 'Islam', 'Islam', 'batam\r\n', 'batam\r\n', '2012-05-12', '2012-05-12', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:25', '2023-12-27 07:45:25', '2023-12-27 07:45:25'),
(32, 'Update', 4399, 4399, '121684678', '121684678', 'Alfath Aprilio\r\n', 'Alfath Aprilio\r\n', 'L', 'L', 'Islam', 'Islam', 'medan\r\n', 'medan\r\n', '2012-05-09', '2012-05-09', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:25', '2023-12-27 07:45:25', '2023-12-27 07:45:25'),
(33, 'Update', 4430, 4430, '121918089', '121918089', 'M. Ahwan Aldiansyah\r\n', 'M. Ahwan Aldiansyah\r\n', 'L', 'L', 'Islam', 'Islam', 'laut dendang\r\n', 'laut dendang\r\n', '2012-07-27', '2012-07-27', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:26', '2023-12-27 07:45:26', '2023-12-27 07:45:26'),
(34, 'Update', 4555, 4555, '121965764', '121965764', 'Putri Alya BR Pane\r\n', 'Putri Alya BR Pane\r\n', 'P', 'P', 'Islam', 'Islam', 'MEDAN\r\n', 'MEDAN\r\n', '2011-12-01', '2011-12-01', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:26', '2023-12-27 07:45:26', '2023-12-27 07:45:26'),
(35, 'Update', 4873, 4873, '122216957', '122216957', 'Afika Fitria', 'Afika Fitria', 'P', 'P', 'Islam', 'Islam', 'Pisang Pala', 'Pisang Pala', '2012-06-20', '2012-06-20', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:45:26', '2023-12-27 07:45:26', '2023-12-27 07:45:26'),
(36, 'Update', 4457, 4457, '122285445', '122285445', 'Raffiqa Radhila', 'Raffiqa Radhila', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2012-05-18', '2012-05-18', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:26', '2023-12-27 07:45:26', '2023-12-27 07:45:26'),
(37, 'Update', 4431, 4431, '122572975', '122572975', 'M. Arya Afandi\r\n', 'M. Arya Afandi\r\n', 'L', 'L', 'Islam', 'Islam', 'laut dendang\r\n', 'laut dendang\r\n', '2012-05-27', '2012-05-27', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:45:27', '2023-12-27 07:45:27', '2023-12-27 07:45:27'),
(38, 'Update', 4405, 4405, '122829943', '122829943', 'Amelia Syahfitri', 'Amelia Syahfitri', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2012-03-20', '2012-03-20', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:27', '2023-12-27 07:45:27', '2023-12-27 07:45:27'),
(39, 'Update', 4475, 4475, '123011525', '123011525', 'Vindeza Cipta', 'Vindeza Cipta', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2012-05-02', '2012-05-02', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:27', '2023-12-27 07:45:27', '2023-12-27 07:45:27'),
(40, 'Update', 4419, 4419, '123219434', '123219434', 'Fadhil Syahnata', 'Fadhil Syahnata', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2012-01-01', '2012-01-01', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:28', '2023-12-27 07:45:28', '2023-12-27 07:45:28'),
(41, 'Update', 4339, 4339, '124012757', '124012757', 'Muhammad Abil', 'Muhammad Abil', 'L', 'L', 'Islam', 'Islam', 'Medan Estate', 'Medan Estate', '2012-08-09', '2012-08-09', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:28', '2023-12-27 07:45:28', '2023-12-27 07:45:28'),
(42, 'Update', 4429, 4429, '124521764', '124521764', 'M. Aditya\r\n', 'M. Aditya\r\n', 'L', 'L', 'Islam', 'Islam', 'banda aceh\r\n', 'banda aceh\r\n', '2012-03-06', '2012-03-06', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:28', '2023-12-27 07:45:28', '2023-12-27 07:45:28'),
(43, 'Update', 4466, 4466, '125024029', '125024029', 'Ririn Dwi Yanti', 'Ririn Dwi Yanti', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2012-12-14', '2012-12-14', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:29', '2023-12-27 07:45:29', '2023-12-27 07:45:29'),
(44, 'Update', 4463, 4463, '125077963', '125077963', 'Revan Syaban Albuqohri', 'Revan Syaban Albuqohri', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2012-06-27', '2012-06-27', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:29', '2023-12-27 07:45:29', '2023-12-27 07:45:29'),
(45, 'Update', 4474, 4474, '125349355', '125349355', 'Theo Didik Pratama', 'Theo Didik Pratama', 'L', 'L', 'Islam', 'Islam', 'Bandar Setia', 'Bandar Setia', '2012-04-04', '2012-04-04', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:29', '2023-12-27 07:45:29', '2023-12-27 07:45:29'),
(46, 'Update', 4462, 4462, '125523717', '125523717', 'Rapa Fanduwi', 'Rapa Fanduwi', 'L', 'L', 'Islam', 'Islam', 'Batubara', 'Batubara', '2012-01-16', '2012-01-16', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:29', '2023-12-27 07:45:29', '2023-12-27 07:45:29'),
(47, 'Update', 4437, 4437, '125578023', '125578023', 'Mhd. Rafa Naufal Kamil', 'Mhd. Rafa Naufal Kamil', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2012-06-29', '2012-06-29', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:30', '2023-12-27 07:45:30', '2023-12-27 07:45:30'),
(48, 'Update', 4417, 4417, '125619208', '125619208', 'Fachri Ramadhan\r\n', 'Fachri Ramadhan\r\n', 'L', 'L', 'Islam', 'Islam', 'medan\r\n', 'medan\r\n', '2012-08-16', '2012-08-16', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:30', '2023-12-27 07:45:30', '2023-12-27 07:45:30'),
(49, 'Update', 4478, 4478, '126132073', '126132073', 'Yoga Pratama', 'Yoga Pratama', 'L', 'L', 'Islam', 'Islam', 'Batubara', 'Batubara', '2012-04-17', '2012-04-17', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:30', '2023-12-27 07:45:30', '2023-12-27 07:45:30'),
(50, 'Update', 5026, 5026, '126487608', '126487608', 'M Ikhsan Al Ragil\r\n', 'M Ikhsan Al Ragil\r\n', 'L', 'L', 'Islam', 'Islam', 'Deli Serdang\r\n', 'Deli Serdang\r\n', '2012-06-28', '2012-06-28', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:31', '2023-12-27 07:45:31', '2023-12-27 07:45:31'),
(51, 'Update', 4591, 4591, '126825440', '126825440', 'Zakhy Ferdiansyah\r\n', 'Zakhy Ferdiansyah\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2012-09-18', '2012-09-18', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:31', '2023-12-27 07:45:31', '2023-12-27 07:45:31'),
(52, 'Update', 4458, 4458, '126889152', '126889152', 'Raiqah Rachmad Nasution', 'Raiqah Rachmad Nasution', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2012-10-02', '2012-10-02', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:31', '2023-12-27 07:45:31', '2023-12-27 07:45:31'),
(53, 'Update', 4450, 4450, '127210210', '127210210', 'Nazwa Lutfiyah', 'Nazwa Lutfiyah', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2012-09-17', '2012-09-17', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:31', '2023-12-27 07:45:31', '2023-12-27 07:45:31'),
(54, 'Update', 4410, 4410, '127511284', '127511284', 'Azhari Alif Andika\r\n', 'Azhari Alif Andika\r\n', 'L', 'L', 'Islam', 'Islam', 'medan\r\n', 'medan\r\n', '2012-02-02', '2012-02-02', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:32', '2023-12-27 07:45:32', '2023-12-27 07:45:32'),
(55, 'Update', 4645, 4645, '127673587', '127673587', 'DWI ARYA PRATAMA\r\n', 'DWI ARYA PRATAMA\r\n', 'L', 'L', 'Islam', 'Islam', 'MEDAN\r\n', 'MEDAN\r\n', '2012-09-09', '2012-09-09', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:45:32', '2023-12-27 07:45:32', '2023-12-27 07:45:32'),
(56, 'Update', 4526, 4526, '127823420', '127823420', 'Kaisa Devilia', 'Kaisa Devilia', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2012-11-19', '2012-11-19', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:32', '2023-12-27 07:45:32', '2023-12-27 07:45:32'),
(57, 'Update', 4735, 4735, '127949295', '127949295', 'Bagus Prasetyo', 'Bagus Prasetyo', 'L', 'L', 'Islam', 'Islam', 'Langkat', 'Langkat', '2012-06-12', '2012-06-12', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:33', '2023-12-27 07:45:33', '2023-12-27 07:45:33'),
(58, 'Update', 4418, 4418, '128005889', '128005889', 'Fadhil Guntara Matondang\r\n', 'Fadhil Guntara Matondang\r\n', 'L', 'L', 'Islam', 'Islam', 'laut dendang\r\n', 'laut dendang\r\n', '2012-10-13', '2012-10-13', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:33', '2023-12-27 07:45:33', '2023-12-27 07:45:33'),
(59, 'Update', 4422, 4422, '128283086', '128283086', 'Hardiansyah Reyhan Pratama\r\n', 'Hardiansyah Reyhan Pratama\r\n', 'L', 'L', 'Islam', 'Islam', 'laut dendang\r\n', 'laut dendang\r\n', '2012-03-02', '2012-03-02', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:33', '2023-12-27 07:45:33', '2023-12-27 07:45:33'),
(60, 'Update', 4403, 4403, '128487431', '128487431', 'Alief Pratama Silalahi', 'Alief Pratama Silalahi', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2012-07-16', '2012-07-16', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:33', '2023-12-27 07:45:33', '2023-12-27 07:45:33'),
(61, 'Update', 4436, 4436, '128526738', '128526738', 'Mhd. Alda Wira', 'Mhd. Alda Wira', 'L', 'L', 'Islam', 'Islam', 'Medan Estate', 'Medan Estate', '2012-06-23', '2012-06-23', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:34', '2023-12-27 07:45:34', '2023-12-27 07:45:34'),
(62, 'Update', 4426, 4426, '128766400', '128766400', 'Jelita Mutiara Putri\r\n', 'Jelita Mutiara Putri\r\n', 'P', 'P', 'Islam', 'Islam', 'laut dendang\r\n', 'laut dendang\r\n', '2012-08-23', '2012-08-23', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:34', '2023-12-27 07:45:34', '2023-12-27 07:45:34'),
(63, 'Update', 4416, 4416, '129263104', '129263104', 'DWI ATTIQAAH PUTRI\r\n', 'DWI ATTIQAAH PUTRI\r\n', 'P', 'P', 'Islam', 'Islam', 'LAUT DENDANG\r\n', 'LAUT DENDANG\r\n', '2012-07-08', '2012-07-08', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:34', '2023-12-27 07:45:34', '2023-12-27 07:45:34'),
(64, 'Update', 4439, 4439, '129431541', '129431541', 'Muhammad Azzam', 'Muhammad Azzam', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2012-01-04', '2012-01-04', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:34', '2023-12-27 07:45:34', '2023-12-27 07:45:34'),
(65, 'Update', 4533, 4533, '129498271', '129498271', 'Muhammad Abdul Dzakiy', 'Muhammad Abdul Dzakiy', 'L', 'L', 'Islam', 'Islam', 'Bangun Rejo', 'Bangun Rejo', '2012-12-31', '2012-12-31', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:35', '2023-12-27 07:45:35', '2023-12-27 07:45:35'),
(66, 'Update', 4470, 4470, '129581447', '129581447', 'Riziq Akbar', 'Riziq Akbar', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2012-05-10', '2012-05-10', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:35', '2023-12-27 07:45:35', '2023-12-27 07:45:35'),
(67, 'Update', 4455, 4455, '129678964', '129678964', 'Prabu Arya Rasidin Ahmad', 'Prabu Arya Rasidin Ahmad', 'L', 'L', 'Islam', 'Islam', 'Sei Rotan', 'Sei Rotan', '2012-02-27', '2012-02-27', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:35', '2023-12-27 07:45:35', '2023-12-27 07:45:35'),
(68, 'Update', 5023, 5023, '129743302', '129743302', 'Cut Nisyah Aulia\r\n', 'Cut Nisyah Aulia\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2012-12-12', '2012-12-12', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:36', '2023-12-27 07:45:36', '2023-12-27 07:45:36'),
(69, 'Update', 4659, 4659, '131273654', '131273654', 'Hazizah\r\n', 'Hazizah\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-10-10', '2013-10-10', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:45:36', '2023-12-27 07:45:36', '2023-12-27 07:45:36'),
(70, 'Update', 4531, 4531, '131387655', '131387655', 'Mada Al Fatih', 'Mada Al Fatih', 'L', 'L', 'Islam', 'Islam', 'Tembung', 'Tembung', '2013-07-20', '2013-07-20', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:36', '2023-12-27 07:45:36', '2023-12-27 07:45:36'),
(71, 'Update', 4628, 4628, '132029823', '132029823', 'Amar Joyo Handoko', 'Amar Joyo Handoko', 'L', 'L', 'Islam', 'Islam', 'Langkat', 'Langkat', '2013-10-20', '2013-10-20', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:45:36', '2023-12-27 07:45:36', '2023-12-27 07:45:36'),
(72, 'Update', 4706, 4706, '132126026', '132126026', 'Rivansyah Dewa\r\n', 'Rivansyah Dewa\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-04-11', '2013-04-11', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:45:37', '2023-12-27 07:45:37', '2023-12-27 07:45:37'),
(73, 'Update', 5022, 5022, '133157633', '133157633', 'Alifia Aishyah Zahra\r\n', 'Alifia Aishyah Zahra\r\n', 'P', 'P', 'Islam', 'Islam', 'Langkat\r\n', 'Langkat\r\n', '2013-11-11', '2013-11-11', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:37', '2023-12-27 07:45:37', '2023-12-27 07:45:37'),
(74, 'Update', 4514, 4514, '133408195', '133408195', 'Cahaya Balqis\r\n', 'Cahaya Balqis\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-06-01', '2013-06-01', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:45:37', '2023-12-27 07:45:37', '2023-12-27 07:45:37'),
(75, 'Update', 4518, 4518, '133482268', '133482268', 'Dirga Pramana Putra', 'Dirga Pramana Putra', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2013-06-18', '2013-06-18', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:38', '2023-12-27 07:45:38', '2023-12-27 07:45:38'),
(76, 'Update', 4508, 4508, '134370080', '134370080', 'Armada Jaya Hadi Lubis\r\n', 'Armada Jaya Hadi Lubis\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-10-18', '2013-10-18', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:45:38', '2023-12-27 07:45:38', '2023-12-27 07:45:38'),
(77, 'Update', 5020, 5020, '134549386', '134549386', 'KESYA NABILA PUTRI\r\n', 'KESYA NABILA PUTRI\r\n', 'P', 'P', 'Islam', 'Islam', 'LAUT DENDANG\r\n', 'LAUT DENDANG\r\n', '2013-06-18', '2013-06-18', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:38', '2023-12-27 07:45:38', '2023-12-27 07:45:38'),
(78, 'Update', 4496, 4496, '136321102', '136321102', 'Adibah Mey Safrina', 'Adibah Mey Safrina', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2013-05-26', '2013-05-26', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:38', '2023-12-27 07:45:38', '2023-12-27 07:45:38'),
(79, 'Update', 5011, 5011, '136979298', '136979298', 'Audy Angkasa\r\n', 'Audy Angkasa\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2015-10-09', '2015-10-09', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:45:39', '2023-12-27 07:45:39', '2023-12-27 07:45:39'),
(80, 'Update', 4520, 4520, '137746589', '137746589', 'Eza Al Vino', 'Eza Al Vino', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2013-09-21', '2013-09-21', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:39', '2023-12-27 07:45:39', '2023-12-27 07:45:39'),
(81, 'Update', 4563, 4563, '137862056', '137862056', 'Rara Irdina', 'Rara Irdina', 'P', 'P', 'Islam', 'Islam', 'Kota Tengah', 'Kota Tengah', '2013-04-22', '2013-04-22', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:39', '2023-12-27 07:45:39', '2023-12-27 07:45:39'),
(82, 'Update', 4576, 4576, '138023318', '138023318', 'Suci Amelia\r\n', 'Suci Amelia\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-05-10', '2013-05-10', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:40', '2023-12-27 07:45:40', '2023-12-27 07:45:40'),
(83, 'Update', 4881, 4881, '138796352', '138796352', 'Alfathan Fredy Asyah', 'Alfathan Fredy Asyah', 'L', 'L', 'Islam', 'Islam', 'Binjai', 'Binjai', '2015-12-15', '2015-12-15', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:45:40', '2023-12-27 07:45:40', '2023-12-27 07:45:40'),
(84, 'Update', 4513, 4513, '139760118', '139760118', 'Bunga Khairunnisa', 'Bunga Khairunnisa', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2013-10-29', '2013-10-29', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:40', '2023-12-27 07:45:40', '2023-12-27 07:45:40'),
(85, 'Update', 4712, 4712, '141415799', '141415799', 'Sheddiq Raffa Purnama Manurung\r\n', 'Sheddiq Raffa Purnama Manurung\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-02-27', '2014-02-27', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:45:40', '2023-12-27 07:45:40', '2023-12-27 07:45:40'),
(86, 'Update', 4637, 4637, '141421503', '141421503', 'Azka Huzaifah', 'Azka Huzaifah', 'L', 'L', 'Islam', 'Islam', 'Langkat', 'Langkat', '2014-08-11', '2014-08-11', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:45:41', '2023-12-27 07:45:41', '2023-12-27 07:45:41'),
(87, 'Update', 4714, 4714, '141722399', '141722399', 'Syaqilla Dwi Almira\r\n', 'Syaqilla Dwi Almira\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-05-29', '2014-05-29', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:45:41', '2023-12-27 07:45:41', '2023-12-27 07:45:41'),
(88, 'Update', 4656, 4656, '142407474', '142407474', 'Habibi\r\n', 'Habibi\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-04-10', '2014-04-10', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:45:41', '2023-12-27 07:45:41', '2023-12-27 07:45:41'),
(89, 'Update', 4642, 4642, '142522058', '142522058', 'Devila Ramadhani\r\n', 'Devila Ramadhani\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-07-05', '2014-07-05', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:45:41', '2023-12-27 07:45:41', '2023-12-27 07:45:41'),
(90, 'Update', 4673, 4673, '142817972', '142817972', 'Muhammad Aditya\r\n', 'Muhammad Aditya\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2014-07-24', '2014-07-24', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:45:42', '2023-12-27 07:45:42', '2023-12-27 07:45:42'),
(91, 'Update', 4630, 4630, '143098302', '143098302', 'Anhu Khairi Ardhin\r\n', 'Anhu Khairi Ardhin\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2014-10-30', '2014-10-30', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:45:42', '2023-12-27 07:45:42', '2023-12-27 07:45:42'),
(92, 'Update', 4688, 4688, '143627734', '143627734', 'Nayra Ramadhani\r\n', 'Nayra Ramadhani\r\n', 'P', 'P', 'Islam', 'Islam', 'Bandar Khalipah\r\n', 'Bandar Khalipah\r\n', '2014-07-14', '2014-07-14', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:45:42', '2023-12-27 07:45:42', '2023-12-27 07:45:42'),
(93, 'Update', 4661, 4661, '144539399', '144539399', 'Kirana Kellen\r\n', 'Kirana Kellen\r\n', 'P', 'P', 'Islam', 'Islam', 'Prabumulih\r\n', 'Prabumulih\r\n', '2014-07-05', '2014-07-05', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:45:43', '2023-12-27 07:45:43', '2023-12-27 07:45:43'),
(94, 'Update', 4679, 4679, '147629217', '147629217', 'Muhammad Riyan Ramadan\r\n', 'Muhammad Riyan Ramadan\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2014-06-26', '2014-06-26', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:45:43', '2023-12-27 07:45:43', '2023-12-27 07:45:43'),
(95, 'Update', 4814, 4814, '147840265', '147840265', 'Nabilla Aprila\r\n', 'Nabilla Aprila\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-04-26', '2014-04-26', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:45:43', '2023-12-27 07:45:43', '2023-12-27 07:45:43'),
(96, 'Update', 4681, 4681, '148828864', '148828864', 'Nadien Putri Amelia\r\n', 'Nadien Putri Amelia\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-06-08', '2014-06-08', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:45:43', '2023-12-27 07:45:43', '2023-12-27 07:45:43'),
(97, 'Update', 4805, 4805, '152722565', '152722565', 'M. Zulfikri\r\n', 'M. Zulfikri\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2015-01-25', '2015-01-25', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:45:44', '2023-12-27 07:45:44', '2023-12-27 07:45:44'),
(98, 'Update', 4884, 4884, '159921812', '159921812', 'Amira', 'Amira', 'P', 'P', 'Islam', 'Islam', 'Medans', 'Medans', '2015-09-26', '2015-09-26', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:45:44', '2023-12-27 07:45:44', '2023-12-27 07:45:44'),
(99, 'Update', 5012, 5012, '3104413859', '3104413859', 'Andika Syaputra\r\n', 'Andika Syaputra\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2010-05-27', '2010-05-27', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:45:44', '2023-12-27 07:45:44', '2023-12-27 07:45:44'),
(100, 'Update', 4409, 4409, '3110560808', '3110560808', 'AULIA NATASYA\r\n', 'AULIA NATASYA\r\n', 'P', 'P', 'Islam', 'Islam', 'SIDEMPUAN\r\n', 'SIDEMPUAN\r\n', '2011-09-11', '2011-09-11', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:45', '2023-12-27 07:45:45', '2023-12-27 07:45:45'),
(101, 'Update', 5006, 5006, '3110720379', '3110720379', 'Kanaya Azzura Harahap\r\n', 'Kanaya Azzura Harahap\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2011-09-19', '2011-09-19', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:45:45', '2023-12-27 07:45:45', '2023-12-27 07:45:45'),
(102, 'Update', 4411, 4411, '3112883586', '3112883586', 'Bima Batara Al Sani\r\n', 'Bima Batara Al Sani\r\n', 'L', 'L', 'Islam', 'Islam', 'Bandar Setia\r\n', 'Bandar Setia\r\n', '2011-11-07', '2011-11-07', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:45', '2023-12-27 07:45:45', '2023-12-27 07:45:45'),
(103, 'Update', 5021, 5021, '3112936976', '3112936976', 'RANGGA PRATAMA\r\n', 'RANGGA PRATAMA\r\n', 'L', 'L', 'Islam', 'Islam', 'Bandar Setia\r\n', 'Bandar Setia\r\n', '2012-12-27', '2012-12-27', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:45', '2023-12-27 07:45:45', '2023-12-27 07:45:45'),
(104, 'Update', 4408, 4408, '3114993252', '3114993252', 'Assifa Syakira\r\n', 'Assifa Syakira\r\n', 'P', 'P', 'Islam', 'Islam', 'medan\r\n', 'medan\r\n', '2011-12-06', '2011-12-06', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:46', '2023-12-27 07:45:46', '2023-12-27 07:45:46'),
(105, 'Update', 4556, 4556, '3115923861', '3115923861', 'Putri Anita\r\n', 'Putri Anita\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2011-10-30', '2011-10-30', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:46', '2023-12-27 07:45:46', '2023-12-27 07:45:46'),
(106, 'Update', 4461, 4461, '3116729075', '3116729075', 'Rangga Ramadhan Pangaribuan', 'Rangga Ramadhan Pangaribuan', 'L', 'L', 'Islam', 'Islam', 'Bandar Setia', 'Bandar Setia', '2011-08-12', '2011-08-12', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:46', '2023-12-27 07:45:46', '2023-12-27 07:45:46'),
(107, 'Update', 4993, 4993, '3118799397', '3118799397', 'Inayah Alifia Syachrani\r\n', 'Inayah Alifia Syachrani\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2011-11-04', '2011-11-04', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:47', '2023-12-27 07:45:47', '2023-12-27 07:45:47'),
(108, 'Update', 4521, 4521, '3121142720', '3121142720', 'Fahmi Fahrezi', 'Fahmi Fahrezi', 'L', 'L', 'Islam', 'Islam', 'Medan Estate', 'Medan Estate', '2012-07-26', '2012-07-26', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:47', '2023-12-27 07:45:47', '2023-12-27 07:45:47'),
(109, 'Update', 5027, 5027, '3121535615', '3121535615', 'Al Mushawwiru Zaky\r\n', 'Al Mushawwiru Zaky\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan Estate\r\n', 'Medan Estate\r\n', '2012-12-26', '2012-12-26', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:47', '2023-12-27 07:45:47', '2023-12-27 07:45:47'),
(110, 'Update', 4406, 4406, '3122517292', '3122517292', 'ANAR KHY SUHARNAN\r\n', 'ANAR KHY SUHARNAN\r\n', 'L', 'L', 'Islam', 'Islam', 'SIBARUANG\r\n', 'SIBARUANG\r\n', '2012-06-03', '2012-06-03', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:47', '2023-12-27 07:45:47', '2023-12-27 07:45:47'),
(111, 'Update', 4535, 4535, '3123605240', '3123605240', 'Muhammad Al Hafiizhi', 'Muhammad Al Hafiizhi', 'L', 'L', 'Islam', 'Islam', 'Tembung', 'Tembung', '2012-12-31', '2012-12-31', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:48', '2023-12-27 07:45:48', '2023-12-27 07:45:48'),
(112, 'Update', 4424, 4424, '3123755937', '3123755937', 'Indri Aulia', 'Indri Aulia', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2012-01-24', '2012-01-24', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:48', '2023-12-27 07:45:48', '2023-12-27 07:45:48'),
(113, 'Update', 4557, 4557, '3124420502', '3124420502', 'Putry Sry Rezeky', 'Putry Sry Rezeky', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2012-12-30', '2012-12-30', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:48', '2023-12-27 07:45:48', '2023-12-27 07:45:48'),
(114, 'Update', 4527, 4527, '3124539802', '3124539802', 'Khairunisa\r\n', 'Khairunisa\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2012-12-25', '2012-12-25', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:49', '2023-12-27 07:45:49', '2023-12-27 07:45:49'),
(115, 'Update', 4537, 4537, '3125307366', '3125307366', 'Muhammad Fajar Al Musanif\r\n', 'Muhammad Fajar Al Musanif\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2012-10-13', '2012-10-13', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:49', '2023-12-27 07:45:49', '2023-12-27 07:45:49'),
(116, 'Update', 4734, 4734, '3125384119', '3125384119', 'Abdi Riski Hamdani', 'Abdi Riski Hamdani', 'L', 'L', 'Islam', 'Islam', 'Sei Mencirim', 'Sei Mencirim', '2012-06-01', '2012-06-01', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:49', '2023-12-27 07:45:49', '2023-12-27 07:45:49'),
(117, 'Update', 4337, 4337, '3125405642', '3125405642', 'Miftahul Jannah', 'Miftahul Jannah', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2012-11-20', '2012-11-20', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:49', '2023-12-27 07:45:49', '2023-12-27 07:45:49'),
(118, 'Update', 4401, 4401, '3126666968', '3126666968', 'Alfino Fajar Siregar', 'Alfino Fajar Siregar', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2012-04-05', '2012-04-05', 'Aktif', 'Aktif', 16, 16, '2023-12-27 07:45:50', '2023-12-27 07:45:50', '2023-12-27 07:45:50'),
(119, 'Update', 4567, 4567, '3127308888', '3127308888', 'Rizki Ramadhani\r\n', 'Rizki Ramadhani\r\n', 'L', 'L', 'Islam', 'Islam', 'Bandar Khalipah\r\n', 'Bandar Khalipah\r\n', '2012-08-08', '2012-08-08', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:50', '2023-12-27 07:45:50', '2023-12-27 07:45:50'),
(120, 'Update', 4995, 4995, '3127327970', '3127327970', 'Aziiz Jamiil\r\n', 'Aziiz Jamiil\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2012-02-06', '2012-02-06', 'Aktif', 'Aktif', 15, 15, '2023-12-27 07:45:50', '2023-12-27 07:45:50', '2023-12-27 07:45:50'),
(121, 'Update', 4511, 4511, '3127484318', '3127484318', 'Bintang Maharani\r\n', 'Bintang Maharani\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2012-10-21', '2012-10-21', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:45:51', '2023-12-27 07:45:51', '2023-12-27 07:45:51'),
(122, 'Update', 5024, 5024, '3127646794', '3127646794', 'Muhammad Rianda Pratama\r\n', 'Muhammad Rianda Pratama\r\n', 'L', 'L', 'Islam', 'Islam', 'P. Johar\r\n', 'P. Johar\r\n', '2012-02-03', '2012-02-03', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:51', '2023-12-27 07:45:51', '2023-12-27 07:45:51'),
(123, 'Update', 4562, 4562, '3128004903', '3128004903', 'Raisa Khairani', 'Raisa Khairani', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2012-12-26', '2012-12-26', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:51', '2023-12-27 07:45:51', '2023-12-27 07:45:51'),
(124, 'Update', 4566, 4566, '3128821352', '3128821352', 'Riski Alpian\r\n', 'Riski Alpian\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan Estate\r\n', 'Medan Estate\r\n', '2012-09-26', '2012-09-26', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:51', '2023-12-27 07:45:51', '2023-12-27 07:45:51'),
(125, 'Update', 5025, 5025, '3129164952', '3129164952', 'Ramadhan Husein\r\n', 'Ramadhan Husein\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2012-11-12', '2012-11-12', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:45:52', '2023-12-27 07:45:52', '2023-12-27 07:45:52'),
(126, 'Update', 4577, 4577, '3129445780', '3129445780', 'Suci Anggraini\r\n', 'Suci Anggraini\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2012-08-19', '2012-08-19', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:52', '2023-12-27 07:45:52', '2023-12-27 07:45:52'),
(127, 'Update', 4545, 4545, '3129630694', '3129630694', 'Nabila Syakila Raya', 'Nabila Syakila Raya', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2012-11-02', '2012-11-02', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:52', '2023-12-27 07:45:52', '2023-12-27 07:45:52'),
(128, 'Update', 4647, 4647, '3130098937', '3130098937', 'Egi Herdiansyah\r\n', 'Egi Herdiansyah\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-11-21', '2013-11-21', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:45:53', '2023-12-27 07:45:53', '2023-12-27 07:45:53'),
(129, 'Update', 4584, 4584, '3131158265', '3131158265', 'Tri Aurel Sopadilla\r\n', 'Tri Aurel Sopadilla\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-10-30', '2013-10-30', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:53', '2023-12-27 07:45:53', '2023-12-27 07:45:53'),
(130, 'Update', 4582, 4582, '3131717373', '3131717373', 'Syifa Amelia\r\n', 'Syifa Amelia\r\n', 'P', 'P', 'Islam', 'Islam', 'Langkat\r\n', 'Langkat\r\n', '2013-01-05', '2013-01-05', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:53', '2023-12-27 07:45:53', '2023-12-27 07:45:53'),
(131, 'Update', 4651, 4651, '3131974435', '3131974435', 'Farid Azhar Siregar\r\n', 'Farid Azhar Siregar\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-08-05', '2013-08-05', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:45:53', '2023-12-27 07:45:53', '2023-12-27 07:45:53'),
(132, 'Update', 4640, 4640, '3132112194', '3132112194', 'Bimbi Alamsyah', 'Bimbi Alamsyah', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2013-04-27', '2013-04-27', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:45:54', '2023-12-27 07:45:54', '2023-12-27 07:45:54'),
(133, 'Update', 4588, 4588, '3132177763', '3132177763', 'Wira Fitra Sanjaya\r\n', 'Wira Fitra Sanjaya\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-08-12', '2013-08-12', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:54', '2023-12-27 07:45:54', '2023-12-27 07:45:54'),
(134, 'Update', 4507, 4507, '3132213003', '3132213003', 'Aprilliya Gusnana Salim Bangun\r\n', 'Aprilliya Gusnana Salim Bangun\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-04-14', '2013-04-14', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:45:54', '2023-12-27 07:45:54', '2023-12-27 07:45:54'),
(135, 'Update', 4657, 4657, '3132214854', '3132214854', 'Hadiansyah Putra\r\n', 'Hadiansyah Putra\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-10-10', '2013-10-10', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:45:54', '2023-12-27 07:45:54', '2023-12-27 07:45:54'),
(136, 'Update', 4698, 4698, '3132265729', '3132265729', 'Putri Anggraini\r\n', 'Putri Anggraini\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-12-04', '2013-12-04', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:45:55', '2023-12-27 07:45:55', '2023-12-27 07:45:55'),
(137, 'Update', 5028, 5028, '3132352474', '3132352474', 'Sofiah Solehah\r\n', 'Sofiah Solehah\r\n', 'P', 'P', 'Islam', 'Islam', 'Batam\r\n', 'Batam\r\n', '2013-01-01', '2013-01-01', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:55', '2023-12-27 07:45:55', '2023-12-27 07:45:55'),
(138, 'Update', 4530, 4530, '3132359715', '3132359715', 'M. Bagas Prakoso Sahputra\r\n', 'M. Bagas Prakoso Sahputra\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-04-12', '2013-04-12', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:45:55', '2023-12-27 07:45:55', '2023-12-27 07:45:55'),
(139, 'Update', 4538, 4538, '3132372335', '3132372335', 'Muhammad Farid Alfiqri\r\n', 'Muhammad Farid Alfiqri\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-07-02', '2013-07-02', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:56', '2023-12-27 07:45:56', '2023-12-27 07:45:56'),
(140, 'Update', 4522, 4522, '3132431803', '3132431803', 'Febryka Triani\r\n', 'Febryka Triani\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-03-18', '2013-03-18', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:56', '2023-12-27 07:45:56', '2023-12-27 07:45:56'),
(141, 'Update', 4641, 4641, '3132770037', '3132770037', 'Dafa Pratama\r\n', 'Dafa Pratama\r\n', 'L', 'L', 'Islam', 'Islam', 'Lubuk Sabau\r\n', 'Lubuk Sabau\r\n', '2013-10-14', '2013-10-14', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:45:56', '2023-12-27 07:45:56', '2023-12-27 07:45:56'),
(142, 'Update', 4565, 4565, '3132949244', '3132949244', 'Rifqi\r\n', 'Rifqi\r\n', 'L', 'L', 'Islam', 'Islam', 'Sampali\r\n', 'Sampali\r\n', '2013-05-21', '2013-05-21', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:56', '2023-12-27 07:45:56', '2023-12-27 07:45:56'),
(143, 'Update', 4649, 4649, '3133071670', '3133071670', 'Fairah Naylatul Izzah Noor\r\n', 'Fairah Naylatul Izzah Noor\r\n', 'P', 'P', 'Islam', 'Islam', 'Bandar Setia\r\n', 'Bandar Setia\r\n', '2013-10-26', '2013-10-26', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:45:57', '2023-12-27 07:45:57', '2023-12-27 07:45:57'),
(144, 'Update', 4655, 4655, '3133295476', '3133295476', 'Gilang Alviano\r\n', 'Gilang Alviano\r\n', 'L', 'L', 'Islam', 'Islam', 'Malaysia\r\n', 'Malaysia\r\n', '2013-07-15', '2013-07-15', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:45:57', '2023-12-27 07:45:57', '2023-12-27 07:45:57'),
(145, 'Update', 4523, 4523, '3133302028', '3133302028', 'Fero Al Bian', 'Fero Al Bian', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2013-09-15', '2013-09-15', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:57', '2023-12-27 07:45:57', '2023-12-27 07:45:57'),
(146, 'Update', 4515, 4515, '3133379581', '3133379581', 'Cantika Putri Ajuini\r\n', 'Cantika Putri Ajuini\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-06-05', '2013-06-05', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:45:58', '2023-12-27 07:45:58', '2023-12-27 07:45:58'),
(147, 'Update', 4573, 4573, '3133726814', '3133726814', 'SANICAH', 'SANICAH', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2013-04-24', '2013-04-24', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:58', '2023-12-27 07:45:58', '2023-12-27 07:45:58'),
(148, 'Update', 4504, 4504, '3133968405', '3133968405', 'Alifa Rizka Khairani\r\n', 'Alifa Rizka Khairani\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-08-19', '2013-08-19', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:45:58', '2023-12-27 07:45:58', '2023-12-27 07:45:58'),
(149, 'Update', 4625, 4625, '3134062366', '3134062366', 'Aisyah Safriani Harahap\r\n', 'Aisyah Safriani Harahap\r\n', 'P', 'P', 'Islam', 'Islam', 'Tembung\r\n', 'Tembung\r\n', '2013-11-09', '2013-11-09', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:45:58', '2023-12-27 07:45:58', '2023-12-27 07:45:58'),
(150, 'Update', 4680, 4680, '3134424647', '3134424647', 'Muhammad Saddam Shayfullah\r\n', 'Muhammad Saddam Shayfullah\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-11-18', '2013-11-18', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:45:59', '2023-12-27 07:45:59', '2023-12-27 07:45:59'),
(151, 'Update', 4497, 4497, '3134831099', '3134831099', 'Afifah Mahira', 'Afifah Mahira', 'P', 'P', 'Islam', 'Islam', 'Medan Estate', 'Medan Estate', '2013-10-19', '2013-10-19', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:45:59', '2023-12-27 07:45:59', '2023-12-27 07:45:59'),
(152, 'Update', 4509, 4509, '3135162157', '3135162157', 'Aufa Al Rasyid Lubis\r\n', 'Aufa Al Rasyid Lubis\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-01-10', '2013-01-10', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:45:59', '2023-12-27 07:45:59', '2023-12-27 07:45:59'),
(153, 'Update', 4653, 4653, '3135283395', '3135283395', 'Fitri Anjani\r\n', 'Fitri Anjani\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-10-19', '2013-10-19', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:46:00', '2023-12-27 07:46:00', '2023-12-27 07:46:00'),
(154, 'Update', 5005, 5005, '3135455225', '3135455225', 'JOREITA SEMBIRING\r\n', 'JOREITA SEMBIRING\r\n', 'P', 'P', 'Islam', 'Islam', 'MEDAN\r\n', 'MEDAN\r\n', '2013-07-27', '2013-07-27', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:46:00', '2023-12-27 07:46:00', '2023-12-27 07:46:00'),
(155, 'Update', 4737, 4737, '3135712782', '3135712782', 'Alya Febiyanti\r\n\r\n', 'Alya Febiyanti\r\n\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-02-16', '2013-02-16', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:46:00', '2023-12-27 07:46:00', '2023-12-27 07:46:00'),
(156, 'Update', 4506, 4506, '3136017780', '3136017780', 'Anugrah Ferdiansyah\r\n', 'Anugrah Ferdiansyah\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-02-11', '2013-02-11', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:46:00', '2023-12-27 07:46:00', '2023-12-27 07:46:00'),
(157, 'Update', 4517, 4517, '3136182679', '3136182679', 'Daru Dwi Prawira\r\n', 'Daru Dwi Prawira\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-05-28', '2013-05-28', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:46:01', '2023-12-27 07:46:01', '2023-12-27 07:46:01'),
(158, 'Update', 2021, 2021, '3136222445', '3136222445', 'Rizky Perasetiyo\r\n', 'Rizky Perasetiyo\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-03-06', '2013-03-06', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:01', '2023-12-27 07:46:01', '2023-12-27 07:46:01'),
(159, 'Update', 4669, 4669, '3136417741', '3136417741', 'Mhd Farhan Nasution', 'Mhd Farhan Nasution', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2013-10-24', '2013-10-24', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:01', '2023-12-27 07:46:01', '2023-12-27 07:46:01'),
(160, 'Update', 5074, 5074, '3136489121', '3136489121', 'Fathan Anugerah Hubaini', 'Fathan Anugerah Hubaini', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2013-10-19', '2013-10-19', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:02', '2023-12-27 07:46:02', '2023-12-27 07:46:02'),
(161, 'Update', 4662, 4662, '3136720456', '3136720456', 'Lasmana Prasetian\r\n', 'Lasmana Prasetian\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan Estate\r\n', 'Medan Estate\r\n', '2013-01-17', '2013-01-17', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:46:02', '2023-12-27 07:46:02', '2023-12-27 07:46:02'),
(162, 'Update', 4666, 4666, '3136929608', '3136929608', 'M. Yusuf Al-Syaidi', 'M. Yusuf Al-Syaidi', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2013-11-05', '2013-11-05', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:02', '2023-12-27 07:46:02', '2023-12-27 07:46:02'),
(163, 'Update', 4693, 4693, '3137062523', '3137062523', 'Nur Ain\r\n', 'Nur Ain\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-12-26', '2013-12-26', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:46:02', '2023-12-27 07:46:02', '2023-12-27 07:46:02'),
(164, 'Update', 4510, 4510, '3137094997', '3137094997', 'Ayunda Azzahra\r\n', 'Ayunda Azzahra\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-04-10', '2013-04-10', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:46:03', '2023-12-27 07:46:03', '2023-12-27 07:46:03'),
(165, 'Update', 4536, 4536, '3137311870', '3137311870', 'Muhammad Alduwin', 'Muhammad Alduwin', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2013-01-05', '2013-01-05', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:46:03', '2023-12-27 07:46:03', '2023-12-27 07:46:03'),
(166, 'Update', 4519, 4519, '3137590732', '3137590732', 'Dyo Febriansyah', 'Dyo Febriansyah', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2013-02-26', '2013-02-26', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:46:03', '2023-12-27 07:46:03', '2023-12-27 07:46:03'),
(167, 'Update', 4578, 4578, '3137694925', '3137694925', 'Suci Dafina\r\n', 'Suci Dafina\r\n', 'P', 'P', 'Islam', 'Islam', 'Binjai\r\n', 'Binjai\r\n', '2013-08-07', '2013-08-07', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:46:04', '2023-12-27 07:46:04', '2023-12-27 07:46:04'),
(168, 'Update', 4500, 4500, '3137799710', '3137799710', 'Aidil Akbar\r\n', 'Aidil Akbar\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2013-08-11', '2013-08-11', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:46:04', '2023-12-27 07:46:04', '2023-12-27 07:46:04'),
(169, 'Update', 4539, 4539, '3137831353', '3137831353', 'Muhammad Krisna\r\n', 'Muhammad Krisna\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-02-08', '2013-02-08', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:46:04', '2023-12-27 07:46:04', '2023-12-27 07:46:04'),
(170, 'Update', 4678, 4678, '3137875688', '3137875688', 'Muhammad Rasyid Septian', 'Muhammad Rasyid Septian', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2013-09-20', '2013-09-20', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:04', '2023-12-27 07:46:04', '2023-12-27 07:46:04'),
(171, 'Update', 4796, 4796, '3138010649', '3138010649', 'Hamilah Habsari\r\n', 'Hamilah Habsari\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-11-30', '2013-11-30', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:05', '2023-12-27 07:46:05', '2023-12-27 07:46:05'),
(172, 'Update', 4817, 4817, '3138193007', '3138193007', 'Nayla Yasmin\r\n', 'Nayla Yasmin\r\n', 'L', 'L', 'Islam', 'Islam', 'Sampali\r\n', 'Sampali\r\n', '2013-10-11', '2013-10-11', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:05', '2023-12-27 07:46:05', '2023-12-27 07:46:05'),
(173, 'Update', 4676, 4676, '3138367847', '3138367847', 'Muhammad Getar Syuhada', 'Muhammad Getar Syuhada', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2013-12-27', '2013-12-27', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:05', '2023-12-27 07:46:05', '2023-12-27 07:46:05'),
(174, 'Update', 4501, 4501, '3138689153', '3138689153', 'Aina Talita Zahran\r\n', 'Aina Talita Zahran\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan Estate\r\n', 'Medan Estate\r\n', '2013-08-10', '2013-08-10', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:46:05', '2023-12-27 07:46:05', '2023-12-27 07:46:05'),
(175, 'Update', 4561, 4561, '3138728041', '3138728041', 'Rahmad Darmawan Lubis', 'Rahmad Darmawan Lubis', 'L', 'L', 'Islam', 'Islam', 'Medan Estate', 'Medan Estate', '2013-11-26', '2013-11-26', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:46:06', '2023-12-27 07:46:06', '2023-12-27 07:46:06'),
(176, 'Update', 4823, 4823, '3138748026', '3138748026', 'Nurin Eiliyah Parinduri\r\n', 'Nurin Eiliyah Parinduri\r\n', 'P', 'P', 'Islam', 'Islam', 'Tanjung Morawa\r\n', 'Tanjung Morawa\r\n', '2013-12-01', '2013-12-01', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:06', '2023-12-27 07:46:06', '2023-12-27 07:46:06'),
(177, 'Update', 4672, 4672, '3138821566', '3138821566', 'Muamar Zain', 'Muamar Zain', 'L', 'L', 'Islam', 'Islam', 'Tangerang', 'Tangerang', '2013-12-18', '2013-12-18', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:06', '2023-12-27 07:46:06', '2023-12-27 07:46:06'),
(178, 'Update', 4633, 4633, '3138980141', '3138980141', 'Aqila Salsabila\r\n', 'Aqila Salsabila\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-09-20', '2013-09-20', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:07', '2023-12-27 07:46:07', '2023-12-27 07:46:07'),
(179, 'Update', 4674, 4674, '3139205645', '3139205645', 'Muhammad Alfarizi', 'Muhammad Alfarizi', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2013-04-03', '2013-04-03', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:07', '2023-12-27 07:46:07', '2023-12-27 07:46:07'),
(180, 'Update', 4512, 4512, '3139295314', '3139295314', 'Bulan Ramadhany Arfan Lubis\r\n', 'Bulan Ramadhany Arfan Lubis\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-07-11', '2013-07-11', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:46:07', '2023-12-27 07:46:07', '2023-12-27 07:46:07');
INSERT INTO `log_tbl_siswas` (`id`, `aksi`, `nipd_lama`, `nipd_baru`, `nisn_lama`, `nisn_baru`, `nama_siswa_lama`, `nama_siswa_baru`, `jk_siswa_lama`, `jk_siswa_baru`, `agama_siswa_lama`, `agama_siswa_baru`, `tempat_lahir_lama`, `tempat_lahir_baru`, `tanggal_lahir_lama`, `tanggal_lahir_baru`, `status_siswa_lama`, `status_siswa_baru`, `id_kelas_lama`, `id_kelas_baru`, `created_at`, `updated_at`, `deleted_at`) VALUES
(181, 'Update', 4554, 4554, '3139391320', '3139391320', 'Padli Fadilah', 'Padli Fadilah', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2013-05-08', '2013-05-08', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:46:07', '2023-12-27 07:46:07', '2023-12-27 07:46:07'),
(182, 'Update', 5004, 5004, '3139485730', '3139485730', 'Azmi Aulifa\r\n', 'Azmi Aulifa\r\n', 'L', 'L', 'Islam', 'Islam', 'Perbaungan\r\n', 'Perbaungan\r\n', '2013-04-21', '2013-04-21', 'Aktif', 'Aktif', 14, 14, '2023-12-27 07:46:08', '2023-12-27 07:46:08', '2023-12-27 07:46:08'),
(183, 'Update', 4547, 4547, '3139703462', '3139703462', 'Najla Dwi Bintang', 'Najla Dwi Bintang', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2013-03-20', '2013-03-20', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:46:08', '2023-12-27 07:46:08', '2023-12-27 07:46:08'),
(184, 'Update', 4550, 4550, '3139709493', '3139709493', 'Nur Shina Kayla\r\n', 'Nur Shina Kayla\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2013-03-23', '2013-03-23', 'Aktif', 'Aktif', 13, 13, '2023-12-27 07:46:08', '2023-12-27 07:46:08', '2023-12-27 07:46:08'),
(185, 'Update', 4648, 4648, '3139841208', '3139841208', 'Fachry Luthfy', 'Fachry Luthfy', 'L', 'L', 'Islam', 'Islam', 'Deli Serdang', 'Deli Serdang', '2013-12-11', '2013-12-11', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:08', '2023-12-27 07:46:08', '2023-12-27 07:46:08'),
(186, 'Update', 4838, 4838, '3140288638', '3140288638', 'Wila Datul Hasanah Hasibuan\r\n', 'Wila Datul Hasanah Hasibuan\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-12-27', '2014-12-27', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:09', '2023-12-27 07:46:09', '2023-12-27 07:46:09'),
(187, 'Update', 4808, 4808, '3140303763', '3140303763', 'Muhammad Azrul Ramadhan\r\n', 'Muhammad Azrul Ramadhan\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-06-20', '2014-06-20', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:09', '2023-12-27 07:46:09', '2023-12-27 07:46:09'),
(188, 'Update', 4802, 4802, '3140403159', '3140403159', 'M. Dimas Darma Wangsa\r\n', 'M. Dimas Darma Wangsa\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-09-10', '2014-09-10', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:09', '2023-12-27 07:46:09', '2023-12-27 07:46:09'),
(189, 'Update', 4836, 4836, '3140479053', '3140479053', 'Tirta Ardiansyah\r\n', 'Tirta Ardiansyah\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2014-11-27', '2014-11-27', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:10', '2023-12-27 07:46:10', '2023-12-27 07:46:10'),
(190, 'Update', 4818, 4818, '3140626689', '3140626689', 'Nazla Qanita Siregar\r\n', 'Nazla Qanita Siregar\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-11-29', '2014-11-29', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:10', '2023-12-27 07:46:10', '2023-12-27 07:46:10'),
(191, 'Update', 5030, 5030, '3140756387', '3140756387', 'Aisyah Marsha\r\n', 'Aisyah Marsha\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-02-03', '2014-02-03', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:10', '2023-12-27 07:46:10', '2023-12-27 07:46:10'),
(192, 'Update', 4840, 4840, '3140867394', '3140867394', 'Zikrie Azhar Raihan\r\n', 'Zikrie Azhar Raihan\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-10-28', '2014-10-28', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:10', '2023-12-27 07:46:10', '2023-12-27 07:46:10'),
(193, 'Update', 4683, 4683, '3140898934', '3140898934', 'Nafira Saqilah', 'Nafira Saqilah', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2014-03-15', '2014-03-15', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:11', '2023-12-27 07:46:11', '2023-12-27 07:46:11'),
(194, 'Update', 4646, 4646, '3141035046', '3141035046', 'Eggy Maulana\r\n', 'Eggy Maulana\r\n', 'L', 'L', 'Islam', 'Islam', 'Diski\r\n', 'Diski\r\n', '2014-02-25', '2014-02-25', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:46:11', '2023-12-27 07:46:11', '2023-12-27 07:46:11'),
(195, 'Update', 4827, 4827, '3141337940', '3141337940', 'Rafa Fauzan Ghani\r\n', 'Rafa Fauzan Ghani\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-01-19', '2014-01-19', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:11', '2023-12-27 07:46:11', '2023-12-27 07:46:11'),
(196, 'Update', 4775, 4775, '3141504477', '3141504477', 'Azka Adhyasta Santoso\r\n', 'Azka Adhyasta Santoso\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-12-29', '2014-12-29', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:12', '2023-12-27 07:46:12', '2023-12-27 07:46:12'),
(197, 'Update', 4639, 4639, '3141626572', '3141626572', 'Bilqis Kanza Talita', 'Bilqis Kanza Talita', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2014-05-05', '2014-05-05', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:12', '2023-12-27 07:46:12', '2023-12-27 07:46:12'),
(198, 'Update', 4820, 4820, '3141648512', '3141648512', 'Nicko Ardinata\r\n', 'Nicko Ardinata\r\n', 'L', 'L', 'Islam', 'Islam', 'Tembung\r\n', 'Tembung\r\n', '2014-08-22', '2014-08-22', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:12', '2023-12-27 07:46:12', '2023-12-27 07:46:12'),
(199, 'Update', 4667, 4667, '3141786410', '3141786410', 'Mhd Alwi Ramadan Lubis\r\n', 'Mhd Alwi Ramadan Lubis\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-06-04', '2014-06-04', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:46:12', '2023-12-27 07:46:12', '2023-12-27 07:46:12'),
(200, 'Update', 4631, 4631, '3141929894', '3141929894', 'Annafiz Sahqir Murtado', 'Annafiz Sahqir Murtado', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2014-02-19', '2014-02-19', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:13', '2023-12-27 07:46:13', '2023-12-27 07:46:13'),
(201, 'Update', 4634, 4634, '3141977021', '3141977021', 'Atika Azra Naidina\r\n', 'Atika Azra Naidina\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-04-01', '2014-04-01', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:46:13', '2023-12-27 07:46:13', '2023-12-27 07:46:13'),
(202, 'Update', 4682, 4682, '3142021462', '3142021462', 'Nadira Andara Lintang Nasution\r\n', 'Nadira Andara Lintang Nasution\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2014-08-26', '2014-08-26', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:46:13', '2023-12-27 07:46:13', '2023-12-27 07:46:13'),
(203, 'Update', 4911, 4911, '3142205925', '3142205925', 'Dwi Bulan Handayani', 'Dwi Bulan Handayani', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-11-17', '2014-11-17', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:13', '2023-12-27 07:46:13', '2023-12-27 07:46:13'),
(204, 'Update', 4652, 4652, '3142357061', '3142357061', 'Fernando Natalyo', 'Fernando Natalyo', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2014-05-21', '2014-05-21', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:14', '2023-12-27 07:46:14', '2023-12-27 07:46:14'),
(205, 'Update', 4848, 4848, '3142519987', '3142519987', 'Muhammad El-Buhari', 'Muhammad El-Buhari', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2014-11-02', '2014-11-02', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:14', '2023-12-27 07:46:14', '2023-12-27 07:46:14'),
(206, 'Update', 4638, 4638, '3142764556', '3142764556', 'Balqis Zivana Putri', 'Balqis Zivana Putri', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2014-04-13', '2014-04-13', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:14', '2023-12-27 07:46:14', '2023-12-27 07:46:14'),
(207, 'Update', 4684, 4684, '3142768663', '3142768663', 'Nafisah Muharrami Zain\r\n', 'Nafisah Muharrami Zain\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2014-10-31', '2014-10-31', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:46:15', '2023-12-27 07:46:15', '2023-12-27 07:46:15'),
(208, 'Update', 5032, 5032, '3143024915', '3143024915', 'DESWA SALSABILA\r\n', 'DESWA SALSABILA\r\n', 'P', 'P', 'Islam', 'Islam', 'MEDAN\r\n', 'MEDAN\r\n', '2014-09-21', '2014-09-21', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:15', '2023-12-27 07:46:15', '2023-12-27 07:46:15'),
(209, 'Update', 4675, 4675, '3143044044', '3143044044', 'Muhammad Fauzi Al Sandi', 'Muhammad Fauzi Al Sandi', 'L', 'L', 'Islam', 'Islam', 'Medan Estate', 'Medan Estate', '2014-02-28', '2014-02-28', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:15', '2023-12-27 07:46:15', '2023-12-27 07:46:15'),
(210, 'Update', 5037, 5037, '3143109089', '3143109089', 'Zira Antanovia\r\n', 'Zira Antanovia\r\n', 'P', 'P', 'Islam', 'Islam', 'Simalungun\r\n', 'Simalungun\r\n', '2014-11-12', '2014-11-12', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:15', '2023-12-27 07:46:15', '2023-12-27 07:46:15'),
(211, 'Update', 4824, 4824, '3143148307', '3143148307', 'Nurul Amelia MT\r\n', 'Nurul Amelia MT\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-10-15', '2014-10-15', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:16', '2023-12-27 07:46:16', '2023-12-27 07:46:16'),
(212, 'Update', 4665, 4665, '3143189824', '3143189824', 'M. Rizky Maulana\r\n', 'M. Rizky Maulana\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2014-06-08', '2014-06-08', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:16', '2023-12-27 07:46:16', '2023-12-27 07:46:16'),
(213, 'Update', 4664, 4664, '3143703485', '3143703485', 'M. Rizki Affandi', 'M. Rizki Affandi', 'L', 'L', 'Islam', 'Islam', 'Bandar Khalipah', 'Bandar Khalipah', '2014-04-03', '2014-04-03', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:16', '2023-12-27 07:46:16', '2023-12-27 07:46:16'),
(214, 'Update', 4671, 4671, '3143823968', '3143823968', 'Miyana Puspita\r\n', 'Miyana Puspita\r\n', 'P', 'P', '', '', 'Sampali\r\n', 'Sampali\r\n', '2014-03-15', '2014-03-15', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:46:16', '2023-12-27 07:46:16', '2023-12-27 07:46:16'),
(215, 'Update', 4710, 4710, '3143927473', '3143927473', 'Salsabila Azzahra\r\n', 'Salsabila Azzahra\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-07-27', '2014-07-27', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:46:17', '2023-12-27 07:46:17', '2023-12-27 07:46:17'),
(216, 'Update', 4830, 4830, '3143979209', '3143979209', 'Rezky Prasetyo\r\n', 'Rezky Prasetyo\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-09-09', '2014-09-09', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:17', '2023-12-27 07:46:17', '2023-12-27 07:46:17'),
(217, 'Update', 4701, 4701, '3144361665', '3144361665', 'Rafa Al Zikri\r\n', 'Rafa Al Zikri\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-07-19', '2014-07-19', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:46:17', '2023-12-27 07:46:17', '2023-12-27 07:46:17'),
(218, 'Update', 4977, 4977, '3144536776', '3144536776', 'Yoga Kurniawan Dalimunthe', 'Yoga Kurniawan Dalimunthe', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2014-04-11', '2014-04-11', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:18', '2023-12-27 07:46:18', '2023-12-27 07:46:18'),
(219, 'Update', 4799, 4799, '3144616373', '3144616373', 'Khafi El Hamam Parinduri\r\n', 'Khafi El Hamam Parinduri\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-12-04', '2014-12-04', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:18', '2023-12-27 07:46:18', '2023-12-27 07:46:18'),
(220, 'Update', 4839, 4839, '3144970498', '3144970498', 'Yadi\r\n', 'Yadi\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan Estate\r\n', 'Medan Estate\r\n', '2014-12-03', '2014-12-03', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:18', '2023-12-27 07:46:18', '2023-12-27 07:46:18'),
(221, 'Update', 4835, 4835, '3145127315', '3145127315', 'Surya Gemilang', 'Surya Gemilang', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2014-11-15', '2014-11-15', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:18', '2023-12-27 07:46:18', '2023-12-27 07:46:18'),
(222, 'Update', 4761, 4761, '3145515773', '3145515773', 'Aidil Akbar', 'Aidil Akbar', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2014-10-04', '2014-10-04', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:19', '2023-12-27 07:46:19', '2023-12-27 07:46:19'),
(223, 'Update', 4650, 4650, '3145678900', '3145678900', 'Fakhira Salwa Ramadani\r\n', 'Fakhira Salwa Ramadani\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-07-02', '2014-07-02', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:46:19', '2023-12-27 07:46:19', '2023-12-27 07:46:19'),
(224, 'Update', 4677, 4677, '3145981910', '3145981910', 'Muhammad Manaf Nasution', 'Muhammad Manaf Nasution', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2013-12-27', '2013-12-27', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:19', '2023-12-27 07:46:19', '2023-12-27 07:46:19'),
(225, 'Update', 4704, 4704, '3146021657', '3146021657', 'Reno Al-Farizi\r\n', 'Reno Al-Farizi\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-09-10', '2014-09-10', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:46:20', '2023-12-27 07:46:20', '2023-12-27 07:46:20'),
(226, 'Update', 4654, 4654, '3146311718', '3146311718', 'Gibran Fabio Aska', 'Gibran Fabio Aska', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2013-10-19', '2013-10-19', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:20', '2023-12-27 07:46:20', '2023-12-27 07:46:20'),
(227, 'Update', 4626, 4626, '3146851083', '3146851083', 'Al Fathir Abiyu\r\n', 'Al Fathir Abiyu\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2014-02-19', '2014-02-19', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:20', '2023-12-27 07:46:20', '2023-12-27 07:46:20'),
(228, 'Update', 4807, 4807, '3147089616', '3147089616', 'Mimifa Khairunnisa\r\n', 'Mimifa Khairunnisa\r\n', 'P', 'P', 'Islam', 'Islam', 'Bandar Khalipah\r\n', 'Bandar Khalipah\r\n', '2014-08-17', '2014-08-17', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:20', '2023-12-27 07:46:20', '2023-12-27 07:46:20'),
(229, 'Update', 4629, 4629, '3147158592', '3147158592', 'Andini Putri Pratama\r\n', 'Andini Putri Pratama\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-06-03', '2014-06-03', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:46:21', '2023-12-27 07:46:21', '2023-12-27 07:46:21'),
(230, 'Update', 4837, 4837, '3147300170', '3147300170', 'Ufaira Nur Afifa\r\n', 'Ufaira Nur Afifa\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2014-04-10', '2014-04-10', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:21', '2023-12-27 07:46:21', '2023-12-27 07:46:21'),
(231, 'Update', 4770, 4770, '3147589325', '3147589325', 'Arjuna Arya Al-Qohar\r\n', 'Arjuna Arya Al-Qohar\r\n', 'L', 'L', 'Islam', 'Islam', 'Dumai\r\n', 'Dumai\r\n', '2014-02-08', '2014-02-08', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:21', '2023-12-27 07:46:21', '2023-12-27 07:46:21'),
(232, 'Update', 4689, 4689, '3147851930', '3147851930', 'Nayra Sahbillah Azharah\r\n', 'Nayra Sahbillah Azharah\r\n', 'P', 'P', 'Islam', 'Islam', 'Bandar Setia\r\n', 'Bandar Setia\r\n', '2014-08-12', '2014-08-12', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:46:21', '2023-12-27 07:46:21', '2023-12-27 07:46:21'),
(233, 'Update', 4841, 4841, '3148231089', '3148231089', 'Alika Naila Putri\r\n', 'Alika Naila Putri\r\n', 'P', 'P', 'Islam', 'Islam', 'Bandar Khalipah\r\n', 'Bandar Khalipah\r\n', '2014-06-23', '2014-06-23', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:22', '2023-12-27 07:46:22', '2023-12-27 07:46:22'),
(234, 'Update', 4660, 4660, '3148301517', '3148301517', 'Khairil Fahri\r\n', 'Khairil Fahri\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-01-02', '2014-01-02', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:46:22', '2023-12-27 07:46:22', '2023-12-27 07:46:22'),
(235, 'Update', 4691, 4691, '3148332130', '3148332130', 'Nazihah Muharrami Zain\r\n', 'Nazihah Muharrami Zain\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-10-31', '2014-10-31', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:46:22', '2023-12-27 07:46:22', '2023-12-27 07:46:22'),
(236, 'Update', 4813, 4813, '3148592006', '3148592006', 'Mutiya Zafira\r\n', 'Mutiya Zafira\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-11-09', '2014-11-09', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:23', '2023-12-27 07:46:23', '2023-12-27 07:46:23'),
(237, 'Update', 4636, 4636, '3148594164', '3148594164', 'Azizah Puspitasari\r\n', 'Azizah Puspitasari\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-04-06', '2014-04-06', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:46:23', '2023-12-27 07:46:23', '2023-12-27 07:46:23'),
(238, 'Update', 4764, 4764, '3148788815', '3148788815', 'Alfa Aditya\r\n', 'Alfa Aditya\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-05-01', '2014-05-01', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:23', '2023-12-27 07:46:23', '2023-12-27 07:46:23'),
(239, 'Update', 4760, 4760, '3148795966', '3148795966', 'Agung Prawira\r\n', 'Agung Prawira\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-11-16', '2014-11-16', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:24', '2023-12-27 07:46:24', '2023-12-27 07:46:24'),
(240, 'Update', 4834, 4834, '3148797859', '3148797859', 'Siti Humairah\r\n', 'Siti Humairah\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2014-12-20', '2014-12-20', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:24', '2023-12-27 07:46:24', '2023-12-27 07:46:24'),
(241, 'Update', 4658, 4658, '3148975146', '3148975146', 'Hasby Rahman Lubis', 'Hasby Rahman Lubis', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2014-07-10', '2014-07-10', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:24', '2023-12-27 07:46:24', '2023-12-27 07:46:24'),
(242, 'Update', 4644, 4644, '3149096407', '3149096407', 'Duwi Julianti', 'Duwi Julianti', 'P', 'P', 'Islam', 'Islam', 'Dumai', 'Dumai', '2014-06-04', '2014-06-04', 'Aktif', 'Aktif', 10, 10, '2023-12-27 07:46:24', '2023-12-27 07:46:24', '2023-12-27 07:46:24'),
(243, 'Update', 4627, 4627, '3149648071', '3149648071', 'Al Nadhif Putra Sundana\r\n', 'Al Nadhif Putra Sundana\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-06-14', '2014-06-14', 'Aktif', 'Aktif', 9, 9, '2023-12-27 07:46:25', '2023-12-27 07:46:25', '2023-12-27 07:46:25'),
(244, 'Update', 4663, 4663, '3149654138', '3149654138', 'M. Alcantara Zaffran\r\n', 'M. Alcantara Zaffran\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2014-05-09', '2014-05-09', 'Aktif', 'Aktif', 11, 11, '2023-12-27 07:46:25', '2023-12-27 07:46:25', '2023-12-27 07:46:25'),
(245, 'Update', 5035, 5035, '3149726016', '3149726016', 'Putri Thalita Ulfa\r\n', 'Putri Thalita Ulfa\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2014-03-08', '2014-03-08', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:25', '2023-12-27 07:46:25', '2023-12-27 07:46:25'),
(246, 'Update', 4932, 4932, '3150068038', '3150068038', 'M. Aziz Maulana', 'M. Aziz Maulana', 'L', 'L', 'Islam', 'Islam', 'Medan Estate', 'Medan Estate', '2015-12-12', '2015-12-12', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:26', '2023-12-27 07:46:26', '2023-12-27 07:46:26'),
(247, 'Update', 4901, 4901, '3150108687', '3150108687', 'Chila Mikayla', 'Chila Mikayla', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2015-12-28', '2015-12-28', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:26', '2023-12-27 07:46:26', '2023-12-27 07:46:26'),
(248, 'Update', 4826, 4826, '3150260443', '3150260443', 'Raditya Pratama\r\n', 'Raditya Pratama\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2015-03-21', '2015-03-21', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:26', '2023-12-27 07:46:26', '2023-12-27 07:46:26'),
(249, 'Update', 4904, 4904, '3150283414', '3150283414', 'Daffa Pranaja', 'Daffa Pranaja', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2015-10-09', '2015-10-09', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:26', '2023-12-27 07:46:26', '2023-12-27 07:46:26'),
(250, 'Update', 4871, 4871, '3150517546', '3150517546', 'Adelia Putri', 'Adelia Putri', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2015-10-06', '2015-10-06', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:27', '2023-12-27 07:46:27', '2023-12-27 07:46:27'),
(251, 'Update', 4880, 4880, '3150519547', '3150519547', 'Al Rizky Falistira', 'Al Rizky Falistira', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2015-09-17', '2015-09-17', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:27', '2023-12-27 07:46:27', '2023-12-27 07:46:27'),
(252, 'Update', 4964, 4964, '3150664836', '3150664836', 'Raisya Rahma', 'Raisya Rahma', 'P', 'P', 'Islam', 'Islam', 'B. Khalipah', 'B. Khalipah', '2015-08-05', '2015-08-05', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:27', '2023-12-27 07:46:27', '2023-12-27 07:46:27'),
(253, 'Update', 4846, 4846, '3150949421', '3150949421', 'Nadia Azzahra\r\n', 'Nadia Azzahra\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2015-01-13', '2015-01-13', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:27', '2023-12-27 07:46:27', '2023-12-27 07:46:27'),
(254, 'Update', 4800, 4800, '3151265721', '3151265721', 'Khaira Syahfitri\r\n', 'Khaira Syahfitri\r\n', 'P', 'P', 'Islam', 'Islam', 'Sampali\r\n', 'Sampali\r\n', '2015-07-26', '2015-07-26', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:28', '2023-12-27 07:46:28', '2023-12-27 07:46:28'),
(255, 'Update', 4961, 4961, '3151405271', '3151405271', 'Raffi Dary Abiyyu', 'Raffi Dary Abiyyu', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2015-09-12', '2015-09-12', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:28', '2023-12-27 07:46:28', '2023-12-27 07:46:28'),
(256, 'Update', 4768, 4768, '3151463658', '3151463658', 'Annaura Yasmine\r\n', 'Annaura Yasmine\r\n', 'P', 'P', 'Islam', 'Islam', 'Bandar Selamat\r\n', 'Bandar Selamat\r\n', '2015-04-12', '2015-04-12', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:28', '2023-12-27 07:46:28', '2023-12-27 07:46:28'),
(257, 'Update', 4792, 4792, '3151600636', '3151600636', 'Febrian Syahputra\r\n', 'Febrian Syahputra\r\n', 'L', 'L', 'Islam', 'Islam', 'Tembung\r\n', 'Tembung\r\n', '2015-02-21', '2015-02-21', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:29', '2023-12-27 07:46:29', '2023-12-27 07:46:29'),
(258, 'Update', 5034, 5034, '3151653011', '3151653011', 'MUHAMMAD RAYHAN REFIKANZAH\r\n', 'MUHAMMAD RAYHAN REFIKANZAH\r\n', 'L', 'L', 'Islam', 'Islam', 'Bandar Setia\r\n', 'Bandar Setia\r\n', '2015-01-05', '2015-01-05', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:29', '2023-12-27 07:46:29', '2023-12-27 07:46:29'),
(259, 'Update', 4844, 4844, '3151750034', '3151750034', 'Ihsan Akmal', 'Ihsan Akmal', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2015-05-31', '2015-05-31', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:29', '2023-12-27 07:46:29', '2023-12-27 07:46:29'),
(260, 'Update', 4908, 4908, '3151773197', '3151773197', 'Desy Rahma Sari', 'Desy Rahma Sari', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2015-12-16', '2015-12-16', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:30', '2023-12-27 07:46:30', '2023-12-27 07:46:30'),
(261, 'Update', 4947, 4947, '3151860080', '3151860080', 'Muhammad Satria', 'Muhammad Satria', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2015-02-28', '2015-02-28', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:30', '2023-12-27 07:46:30', '2023-12-27 07:46:30'),
(262, 'Update', 4902, 4902, '3151898759', '3151898759', 'Cleopatra Rensy', 'Cleopatra Rensy', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2015-12-28', '2015-12-28', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:30', '2023-12-27 07:46:30', '2023-12-27 07:46:30'),
(263, 'Update', 4907, 4907, '3152015709', '3152015709', 'Denis Pratama', 'Denis Pratama', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2015-07-10', '2015-07-10', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:30', '2023-12-27 07:46:30', '2023-12-27 07:46:30'),
(264, 'Update', 4903, 4903, '3152049803', '3152049803', 'Dafa', 'Dafa', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2015-10-27', '2015-10-27', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:31', '2023-12-27 07:46:31', '2023-12-27 07:46:31'),
(265, 'Update', 4791, 4791, '3152136053', '3152136053', 'Febiyana', 'Febiyana', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2015-02-06', '2015-02-06', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:31', '2023-12-27 07:46:31', '2023-12-27 07:46:31'),
(266, 'Update', 4795, 4795, '3152285539', '3152285539', 'Hafiza Al-Malika\r\n', 'Hafiza Al-Malika\r\n', 'P', 'P', 'Islam', 'Islam', 'Bandar Setia\r\n', 'Bandar Setia\r\n', '2015-02-13', '2015-02-13', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:31', '2023-12-27 07:46:31', '2023-12-27 07:46:31'),
(267, 'Update', 4883, 4883, '3152516173', '3152516173', 'Alfi Andra Aditya', 'Alfi Andra Aditya', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2015-10-04', '2015-10-04', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:32', '2023-12-27 07:46:32', '2023-12-27 07:46:32'),
(268, 'Update', 4825, 4825, '3152534706', '3152534706', 'Nurul Putri Kharimah\r\n', 'Nurul Putri Kharimah\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan Estatet\r\n', 'Medan Estatet\r\n', '2015-07-10', '2015-07-10', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:32', '2023-12-27 07:46:32', '2023-12-27 07:46:32'),
(269, 'Update', 4785, 4785, '3152614399', '3152614399', 'Doli Al-Hafiz Zaky\r\n', 'Doli Al-Hafiz Zaky\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan Estate\r\n', 'Medan Estate\r\n', '2015-03-12', '2015-03-12', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:32', '2023-12-27 07:46:32', '2023-12-27 07:46:32'),
(270, 'Update', 4975, 4975, '3152691268', '3152691268', 'Vino Raditya', 'Vino Raditya', 'L', 'L', 'Islam', 'Islam', 'Binjai\r\n', 'Binjai\r\n', '2015-07-03', '2015-07-03', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:32', '2023-12-27 07:46:32', '2023-12-27 07:46:32'),
(271, 'Update', 4969, 4969, '3152751369', '3152751369', 'Salsabila', 'Salsabila', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2015-08-26', '2015-08-26', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:33', '2023-12-27 07:46:33', '2023-12-27 07:46:33'),
(272, 'Update', 4984, 4984, '3153039218', '3153039218', 'Imam Ali', 'Imam Ali', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2015-02-20', '2015-02-20', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:33', '2023-12-27 07:46:33', '2023-12-27 07:46:33'),
(273, 'Update', 4801, 4801, '3153103412', '3153103412', 'M. Alfazan\r\n', 'M. Alfazan\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan Estate\r\n', 'Medan Estate\r\n', '2015-10-23', '2015-10-23', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:33', '2023-12-27 07:46:33', '2023-12-27 07:46:33'),
(274, 'Update', 4921, 4921, '3153176485', '3153176485', 'Hafizah Khayyirah Lubna\r\n', 'Hafizah Khayyirah Lubna\r\n', 'P', 'P', 'Islam', 'Islam', 'Depok\r\n', 'Depok\r\n', '2015-05-13', '2015-05-13', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:34', '2023-12-27 07:46:34', '2023-12-27 07:46:34'),
(275, 'Update', 4874, 4874, '3153311551', '3153311551', 'Aisyah Koriah', 'Aisyah Koriah', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2015-02-21', '2015-02-21', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:34', '2023-12-27 07:46:34', '2023-12-27 07:46:34'),
(276, 'Update', 4772, 4772, '3153346241', '3153346241', 'Arka Syafatir Al-Hakim\r\n', 'Arka Syafatir Al-Hakim\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2015-06-17', '2015-06-17', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:34', '2023-12-27 07:46:34', '2023-12-27 07:46:34'),
(277, 'Update', 4976, 4976, '3153501218', '3153501218', 'Virza Andara', 'Virza Andara', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2015-12-24', '2015-12-24', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:34', '2023-12-27 07:46:34', '2023-12-27 07:46:34'),
(278, 'Update', 4829, 4829, '3153796358', '3153796358', 'Rania Putri\r\n', 'Rania Putri\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2015-04-28', '2015-04-28', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:35', '2023-12-27 07:46:35', '2023-12-27 07:46:35'),
(279, 'Update', 4788, 4788, '3153950133', '3153950133', 'Eza Irawan Syahputra\r\n', 'Eza Irawan Syahputra\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan Estate\r\n', 'Medan Estate\r\n', '2015-08-26', '2015-08-26', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:35', '2023-12-27 07:46:35', '2023-12-27 07:46:35'),
(280, 'Update', 4798, 4798, '3154141448', '3154141448', 'Keyla Saputri\r\n', 'Keyla Saputri\r\n', 'L', 'L', 'Islam', 'Islam', 'Bandar Setia\r\n', 'Bandar Setia\r\n', '2015-01-18', '2015-01-18', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:35', '2023-12-27 07:46:35', '2023-12-27 07:46:35'),
(281, 'Update', 4954, 4954, '3154303778', '3154303778', 'Nazwa Khairani Putri', 'Nazwa Khairani Putri', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2015-12-25', '2015-12-25', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:35', '2023-12-27 07:46:35', '2023-12-27 07:46:35'),
(282, 'Update', 4762, 4762, '3154599737', '3154599737', 'Akila Sahira Nasution\r\n', 'Akila Sahira Nasution\r\n', 'P', 'P', 'Islam', 'Islam', 'Bandar Khalipah\r\n', 'Bandar Khalipah\r\n', '2015-03-10', '2015-03-10', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:36', '2023-12-27 07:46:36', '2023-12-27 07:46:36'),
(283, 'Update', 4822, 4822, '3154936826', '3154936826', 'Nuria Rahmah\r\n', 'Nuria Rahmah\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2015-01-22', '2015-01-22', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:36', '2023-12-27 07:46:36', '2023-12-27 07:46:36'),
(284, 'Update', 4941, 4941, '3155218654', '3155218654', 'Muhammad Fariz Akbar', 'Muhammad Fariz Akbar', 'L', 'L', 'Islam', 'Islam', 'Bandar Setia', 'Bandar Setia', '2015-08-25', '2015-08-25', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:36', '2023-12-27 07:46:36', '2023-12-27 07:46:36'),
(285, 'Update', 4819, 4819, '3155462364', '3155462364', 'Nazwa Rahmadina Prasetio\r\n', 'Nazwa Rahmadina Prasetio\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2015-07-04', '2015-07-04', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:37', '2023-12-27 07:46:37', '2023-12-27 07:46:37'),
(286, 'Update', 4816, 4816, '3155746449', '3155746449', 'Naura Balqis Suwanika\r\n', 'Naura Balqis Suwanika\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2015-09-15', '2015-09-15', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:37', '2023-12-27 07:46:37', '2023-12-27 07:46:37'),
(287, 'Update', 4797, 4797, '3155810073', '3155810073', 'Juan Rodis Silalahi\r\n', 'Juan Rodis Silalahi\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2015-04-02', '2015-04-02', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:37', '2023-12-27 07:46:37', '2023-12-27 07:46:37'),
(288, 'Update', 5036, 5036, '3155880886', '3155880886', 'SYAUQI RAMADHAN JUANDA\r\n', 'SYAUQI RAMADHAN JUANDA\r\n', 'L', 'L', 'Islam', 'Islam', 'KLUMPANG KAMPUNG\r\n', 'KLUMPANG KAMPUNG\r\n', '2015-07-14', '2015-07-14', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:37', '2023-12-27 07:46:37', '2023-12-27 07:46:37'),
(289, 'Update', 4893, 4893, '3156386590', '3156386590', 'Asyifa Yuwandira', 'Asyifa Yuwandira', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2015-08-14', '2015-08-14', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:38', '2023-12-27 07:46:38', '2023-12-27 07:46:38'),
(290, 'Update', 4905, 4905, '3156403436', '3156403436', 'Dedek Aldiansyah', 'Dedek Aldiansyah', 'L', 'L', 'Islam', 'Islam', 'Pelawan', 'Pelawan', '2015-10-14', '2015-10-14', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:38', '2023-12-27 07:46:38', '2023-12-27 07:46:38'),
(291, 'Update', 4963, 4963, '3156439610', '3156439610', 'Raisa Syahputri Siregar', 'Raisa Syahputri Siregar', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2015-01-02', '2015-01-02', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:38', '2023-12-27 07:46:38', '2023-12-27 07:46:38'),
(292, 'Update', 4968, 4968, '3156468955', '3156468955', 'Rizky Dwi Anggara', 'Rizky Dwi Anggara', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2015-11-24', '2015-11-24', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:39', '2023-12-27 07:46:39', '2023-12-27 07:46:39'),
(293, 'Update', 4886, 4886, '3156559077', '3156559077', 'Andini Safitri', 'Andini Safitri', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2015-07-28', '2015-07-28', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:39', '2023-12-27 07:46:39', '2023-12-27 07:46:39'),
(294, 'Update', 4909, 4909, '3156726778', '3156726778', 'Dinda Kirana', 'Dinda Kirana', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2015-07-08', '2015-07-08', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:39', '2023-12-27 07:46:39', '2023-12-27 07:46:39'),
(295, 'Update', 4809, 4809, '3156811377', '3156811377', 'Muhammad Dzaki Al Mair\r\n', 'Muhammad Dzaki Al Mair\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2015-02-20', '2015-02-20', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:39', '2023-12-27 07:46:39', '2023-12-27 07:46:39'),
(296, 'Update', 4946, 4946, '3157255269', '3157255269', 'Muhammad Rama', 'Muhammad Rama', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2015-03-01', '2015-03-01', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:40', '2023-12-27 07:46:40', '2023-12-27 07:46:40'),
(297, 'Update', 4786, 4786, '3157264546', '3157264546', 'Dwi Meilany\r\n', 'Dwi Meilany\r\n', 'P', 'P', 'Islam', 'Islam', 'Aceh Barat\r\n', 'Aceh Barat\r\n', '2015-05-07', '2015-05-07', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:40', '2023-12-27 07:46:40', '2023-12-27 07:46:40'),
(298, 'Update', 4793, 4793, '3157285352', '3157285352', 'Gista Khairani\r\n', 'Gista Khairani\r\n', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2015-07-05', '2015-07-05', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:40', '2023-12-27 07:46:40', '2023-12-27 07:46:40'),
(299, 'Update', 4912, 4912, '3157583099', '3157583099', 'Enjeli Purnama', 'Enjeli Purnama', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2015-05-23', '2015-05-23', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:40', '2023-12-27 07:46:40', '2023-12-27 07:46:40'),
(300, 'Update', 4779, 4779, '3157754103', '3157754103', 'Beby Pertiwi\r\n', 'Beby Pertiwi\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2015-09-16', '2015-09-16', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:41', '2023-12-27 07:46:41', '2023-12-27 07:46:41'),
(301, 'Update', 4766, 4766, '3157795443', '3157795443', 'Andhika Iskandar Manik\r\n', 'Andhika Iskandar Manik\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2015-05-07', '2015-05-07', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:41', '2023-12-27 07:46:41', '2023-12-27 07:46:41'),
(302, 'Update', 4794, 4794, '3157951624', '3157951624', 'Haafidzah Aznii Yuwandiera\r\n', 'Haafidzah Aznii Yuwandiera\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan Estate\r\n', 'Medan Estate\r\n', '2015-02-04', '2015-02-04', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:41', '2023-12-27 07:46:41', '2023-12-27 07:46:41'),
(303, 'Update', 4882, 4882, '3158036666', '3158036666', 'Alfazar', 'Alfazar', 'L', 'L', 'Islam', 'Islam', 'Medan Estate', 'Medan Estate', '2015-10-06', '2015-10-06', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:42', '2023-12-27 07:46:42', '2023-12-27 07:46:42'),
(304, 'Update', 4806, 4806, '3158192512', '3158192512', 'Mikayla Aziya Putri\r\n', 'Mikayla Aziya Putri\r\n', 'P', 'P', 'Islam', 'Islam', 'Sei Buluh\r\n', 'Sei Buluh\r\n', '2015-08-23', '2015-08-23', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:42', '2023-12-27 07:46:42', '2023-12-27 07:46:42'),
(305, 'Update', 4769, 4769, '3158294054', '3158294054', 'Aqila Balqis Zahara\r\n', 'Aqila Balqis Zahara\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2015-01-09', '2015-01-09', 'Aktif', 'Aktif', 8, 8, '2023-12-27 07:46:42', '2023-12-27 07:46:42', '2023-12-27 07:46:42'),
(306, 'Update', 4776, 4776, '3158967793', '3158967793', 'Azka Azfar Rabbani\r\n', 'Azka Azfar Rabbani\r\n', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2015-10-03', '2015-10-03', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:42', '2023-12-27 07:46:42', '2023-12-27 07:46:42'),
(307, 'Update', 4774, 4774, '3159493429', '3159493429', 'Aulia Ramadani\r\n', 'Aulia Ramadani\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2015-06-18', '2015-06-18', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:43', '2023-12-27 07:46:43', '2023-12-27 07:46:43'),
(308, 'Update', 4804, 4804, '3159522129', '3159522129', 'M. Raffa Alfiansyah\r\n', 'M. Raffa Alfiansyah\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2015-03-08', '2015-03-08', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:43', '2023-12-27 07:46:43', '2023-12-27 07:46:43'),
(309, 'Update', 4933, 4933, '3159635258', '3159635258', 'M. Malikal Mulki', 'M. Malikal Mulki', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2015-10-31', '2015-10-31', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:43', '2023-12-27 07:46:43', '2023-12-27 07:46:43'),
(310, 'Update', 4821, 4821, '3159736593', '3159736593', 'Noval Febryansyah\r\n', 'Noval Febryansyah\r\n', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang\r\n', 'Laut Dendang\r\n', '2015-02-01', '2015-02-01', 'Aktif', 'Aktif', 7, 7, '2023-12-27 07:46:43', '2023-12-27 07:46:43', '2023-12-27 07:46:43'),
(311, 'Update', 4920, 4920, '3159754378', '3159754378', 'Hafiz Hardiansyah', 'Hafiz Hardiansyah', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2015-10-21', '2015-10-21', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:44', '2023-12-27 07:46:44', '2023-12-27 07:46:44'),
(312, 'Update', 4867, 4867, '3159913172', '3159913172', 'Abdurrahim', 'Abdurrahim', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2015-12-16', '2015-12-16', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:44', '2023-12-27 07:46:44', '2023-12-27 07:46:44'),
(313, 'Update', 4965, 4965, '3160173958', '3160173958', 'Reyfa Nadia Putri', 'Reyfa Nadia Putri', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2016-12-05', '2016-12-05', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:44', '2023-12-27 07:46:44', '2023-12-27 07:46:44'),
(314, 'Update', 4928, 4928, '3160279528', '3160279528', 'Jihan Amelia', 'Jihan Amelia', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2016-05-03', '2016-05-03', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:45', '2023-12-27 07:46:45', '2023-12-27 07:46:45'),
(315, 'Update', 4887, 4887, '3160319072', '3160319072', 'Anindya Alesha Gunawan', 'Anindya Alesha Gunawan', 'P', 'P', 'Islam', 'Islam', 'Pematang Johor', 'Pematang Johor', '2016-01-05', '2016-01-05', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:45', '2023-12-27 07:46:45', '2023-12-27 07:46:45'),
(316, 'Update', 4948, 4948, '3160867576', '3160867576', 'Mutiara', 'Mutiara', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2016-02-15', '2016-02-15', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:45', '2023-12-27 07:46:45', '2023-12-27 07:46:45'),
(317, 'Update', 4960, 4960, '3160927987', '3160927987', 'Rafani Putri Salsabila', 'Rafani Putri Salsabila', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2016-08-11', '2016-08-11', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:45', '2023-12-27 07:46:45', '2023-12-27 07:46:45'),
(318, 'Update', 4866, 4866, '3161344902', '3161344902', 'Abdil Rasya', 'Abdil Rasya', 'L', 'L', 'Islam', 'Islam', 'Sampali', 'Sampali', '2016-04-08', '2016-04-08', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:46', '2023-12-27 07:46:46', '2023-12-27 07:46:46'),
(319, 'Update', 4962, 4962, '3162118714', '3162118714', 'Rafi Adithya Al Khadapi', 'Rafi Adithya Al Khadapi', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2016-02-17', '2016-02-17', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:46', '2023-12-27 07:46:46', '2023-12-27 07:46:46'),
(320, 'Update', 4971, 4971, '3162739615', '3162739615', 'Sila Pirlia', 'Sila Pirlia', 'P', 'P', 'Islam', 'Islam', 'Desa Selamat', 'Desa Selamat', '2016-04-21', '2016-04-21', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:46', '2023-12-27 07:46:46', '2023-12-27 07:46:46'),
(321, 'Update', 4879, 4879, '3163209567', '3163209567', 'Al Pandy Ramadhan', 'Al Pandy Ramadhan', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2016-06-28', '2016-06-28', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:47', '2023-12-27 07:46:47', '2023-12-27 07:46:47'),
(322, 'Update', 4892, 4892, '3163425131', '3163425131', 'Arsyah Rama Putra', 'Arsyah Rama Putra', 'L', 'L', 'Islam', 'Islam', 'Tembung', 'Tembung', '2016-01-13', '2016-01-13', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:47', '2023-12-27 07:46:47', '2023-12-27 07:46:47'),
(323, 'Update', 4923, 4923, '3163456167', '3163456167', 'Hildan Soleh Admaja', 'Hildan Soleh Admaja', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2016-01-22', '2016-01-22', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:47', '2023-12-27 07:46:47', '2023-12-27 07:46:47'),
(324, 'Update', 4900, 4900, '3163561272', '3163561272', 'Bunga Ranjani', 'Bunga Ranjani', 'L', 'L', 'Islam', 'Islam', 'Langkat', 'Langkat', '2016-06-01', '2016-06-01', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:47', '2023-12-27 07:46:47', '2023-12-27 07:46:47'),
(325, 'Update', 4890, 4890, '3163630437', '3163630437', 'Aqilla Al Adzra', 'Aqilla Al Adzra', 'P', 'P', 'Islam', 'Islam', 'Sei Semayang', 'Sei Semayang', '2016-05-05', '2016-05-05', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:48', '2023-12-27 07:46:48', '2023-12-27 07:46:48'),
(326, 'Update', 4930, 4930, '3163904536', '3163904536', 'Kanasya Ayu Dia', 'Kanasya Ayu Dia', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2016-09-05', '2016-09-05', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:48', '2023-12-27 07:46:48', '2023-12-27 07:46:48'),
(327, 'Update', 4913, 4913, '3164216743', '3164216743', 'Fadhli Kurniawan', 'Fadhli Kurniawan', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2016-08-25', '2016-08-25', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:48', '2023-12-27 07:46:48', '2023-12-27 07:46:48'),
(328, 'Update', 4937, 4937, '3164874840', '3164874840', 'Mhd. Rizky Ananda', 'Mhd. Rizky Ananda', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2016-03-05', '2016-03-05', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:48', '2023-12-27 07:46:48', '2023-12-27 07:46:48'),
(329, 'Update', 4981, 4981, '3164892372', '3164892372', 'Zulfan Azhar Raihan', 'Zulfan Azhar Raihan', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2016-04-06', '2016-04-06', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:49', '2023-12-27 07:46:49', '2023-12-27 07:46:49'),
(330, 'Update', 4894, 4894, '3164972877', '3164972877', 'Aurel Natasya', 'Aurel Natasya', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2016-01-06', '2016-01-06', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:49', '2023-12-27 07:46:49', '2023-12-27 07:46:49'),
(331, 'Update', 4938, 4938, '3165037756', '3165037756', 'Mikayla Rastya', 'Mikayla Rastya', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2016-03-02', '2016-03-02', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:49', '2023-12-27 07:46:49', '2023-12-27 07:46:49'),
(332, 'Update', 4936, 4936, '3165365349', '3165365349', 'Mhd. Isa Prayoga', 'Mhd. Isa Prayoga', 'L', 'L', 'Islam', 'Islam', 'Bandar Khalipah', 'Bandar Khalipah', '2014-08-11', '2014-08-11', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:50', '2023-12-27 07:46:50', '2023-12-27 07:46:50'),
(333, 'Update', 4869, 4869, '3165570621', '3165570621', 'Abqari Runako', 'Abqari Runako', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2016-04-27', '2016-04-27', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:50', '2023-12-27 07:46:50', '2023-12-27 07:46:50'),
(334, 'Update', 4974, 4974, '3165780656', '3165780656', 'Uswatun Hasana', 'Uswatun Hasana', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2016-03-15', '2016-03-15', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:50', '2023-12-27 07:46:50', '2023-12-27 07:46:50'),
(335, 'Update', 4888, 4888, '3165855697', '3165855697', 'Annisa Sri Jingga', 'Annisa Sri Jingga', 'P', 'P', 'Islam', 'Islam', 'Langsa', 'Langsa', '2016-01-10', '2016-01-10', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:50', '2023-12-27 07:46:50', '2023-12-27 07:46:50'),
(336, 'Update', 4972, 4972, '3166017319', '3166017319', 'Syahilla Az Zaheerah', 'Syahilla Az Zaheerah', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2016-06-26', '2016-06-26', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:51', '2023-12-27 07:46:51', '2023-12-27 07:46:51'),
(337, 'Update', 4927, 4927, '3166067636', '3166067636', 'Januar Revaldi', 'Januar Revaldi', 'L', 'L', 'Islam', 'Islam', 'Medan Estate', 'Medan Estate', '2016-01-20', '2016-01-20', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:51', '2023-12-27 07:46:51', '2023-12-27 07:46:51'),
(338, 'Update', 4967, 4967, '3166180093', '3166180093', 'Rifka Ramadani Nasution', 'Rifka Ramadani Nasution', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2016-06-17', '2016-06-17', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:51', '2023-12-27 07:46:51', '2023-12-27 07:46:51'),
(339, 'Update', 4931, 4931, '3166424584', '3166424584', 'Keysa Zahra', 'Keysa Zahra', 'P', 'P', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2016-02-19', '2016-02-19', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:51', '2023-12-27 07:46:51', '2023-12-27 07:46:51'),
(340, 'Update', 4910, 4910, '3166869418', '3166869418', 'Diwa Ramdahan', 'Diwa Ramdahan', 'L', 'L', '', '', 'Medan', 'Medan', '2016-06-14', '2016-06-14', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:52', '2023-12-27 07:46:52', '2023-12-27 07:46:52'),
(341, 'Update', 4940, 4940, '3167047726', '3167047726', 'Muhammad Alif Randika', 'Muhammad Alif Randika', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2016-01-04', '2016-01-04', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:52', '2023-12-27 07:46:52', '2023-12-27 07:46:52'),
(342, 'Update', 4870, 4870, '3167128995', '3167128995', 'Abri Syam Rainan Lubis', 'Abri Syam Rainan Lubis', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2016-04-15', '2016-04-15', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:52', '2023-12-27 07:46:52', '2023-12-27 07:46:52'),
(343, 'Update', 4891, 4891, '3167174657', '3167174657', 'Arinka Jhui', 'Arinka Jhui', 'P', 'P', 'Islam', 'Islam', 'Sambirejo Tanjung', 'Sambirejo Tanjung', '2016-01-01', '2016-01-01', 'Aktif', 'Aktif', 6, 6, '2023-12-27 07:46:53', '2023-12-27 07:46:53', '2023-12-27 07:46:53'),
(344, 'Update', 4878, 4878, '3167599223', '3167599223', 'Akila Firzanah Ritonga', 'Akila Firzanah Ritonga', 'P', 'P', 'Islam', 'Islam', 'Pelalawan', 'Pelalawan', '2016-03-01', '2016-03-01', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:53', '2023-12-27 07:46:53', '2023-12-27 07:46:53'),
(345, 'Update', 4945, 4945, '3167616978', '3167616978', 'Muhammad Rafa Anggara', 'Muhammad Rafa Anggara', 'L', 'L', 'Islam', 'Islam', 'Medan', 'Medan', '2016-05-30', '2016-05-30', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:53', '2023-12-27 07:46:53', '2023-12-27 07:46:53'),
(346, 'Update', 4889, 4889, '3167941589', '3167941589', 'Aqila Syahirah Rafifah', 'Aqila Syahirah Rafifah', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2016-03-18', '2016-03-18', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:53', '2023-12-27 07:46:53', '2023-12-27 07:46:53'),
(347, 'Update', 4970, 4970, '3168646248', '3168646248', 'Sandrin Almira', 'Sandrin Almira', 'P', 'P', 'Islam', 'Islam', 'Medan', 'Medan', '2016-08-16', '2016-08-16', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:54', '2023-12-27 07:46:54', '2023-12-27 07:46:54'),
(348, 'Update', 4915, 4915, '3168671924', '3168671924', 'Fiona Adelia\r\n', 'Fiona Adelia\r\n', 'P', 'P', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2016-04-11', '2016-04-11', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:54', '2023-12-27 07:46:54', '2023-12-27 07:46:54'),
(349, 'Update', 4973, 4973, '3169184904', '3169184904', 'Syahira Aulia Putri', 'Syahira Aulia Putri', 'P', 'P', 'Islam', 'Islam', 'Bandar Setia', 'Bandar Setia', '2016-03-30', '2016-03-30', 'Aktif', 'Aktif', 5, 5, '2023-12-27 07:46:54', '2023-12-27 07:46:54', '2023-12-27 07:46:54'),
(350, 'Update', 4897, 4897, '3169812626', '3169812626', 'Azril Athafariz Damanik', 'Azril Athafariz Damanik', 'L', 'L', 'Islam', 'Islam', 'Laut Dendang', 'Laut Dendang', '2016-06-07', '2016-06-07', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:55', '2023-12-27 07:46:55', '2023-12-27 07:46:55'),
(351, 'Update', 4916, 4916, '3169862566', '3169862566', 'Gibran Arzanka Ramadhan', 'Gibran Arzanka Ramadhan', 'L', 'L', 'Islam', 'Islam', 'Medan\r\n', 'Medan\r\n', '2016-06-10', '2016-06-10', 'Aktif', 'Aktif', 4, 4, '2023-12-27 07:46:55', '2023-12-27 07:46:55', '2023-12-27 07:46:55'),
(352, 'Update', 4535, 4535, '3123605240', '3123605240', 'Muhammad Al Hafiizhi', 'Muhammad Al Hafiizhi', 'L', 'L', 'Islam', 'Islam', 'Tembung', 'Tembung', '2012-12-31', '2012-12-31', 'Aktif', 'Aktif', 12, 12, '2023-12-27 07:57:09', '2023-12-27 07:57:09', '2023-12-27 07:57:09');

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
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_12_26_164203_create_permission_tables', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `module_id`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin.kelas.index', 'kelas', 'web', '2023-12-26 09:49:51', NULL),
(2, 'admin.guru.index', 'guru', 'web', '2023-12-26 09:49:51', NULL),
(3, 'admin.siswa.index', 'siswa', 'web', '2023-12-26 09:49:51', NULL),
(4, 'admin.bidang-studi.index', 'bidang-studi', 'web', '2023-12-26 09:49:51', NULL),
(5, 'admin.jadwal-pelajaran.index', 'jadwal-pelajaran', 'web', '2023-12-26 09:49:51', NULL),
(6, 'admin.pegawai.index', 'pegawai', 'web', '2023-12-26 09:49:51', NULL),
(7, 'admin.prestasi.index', 'prestasi', 'web', '2023-12-26 09:49:51', NULL),
(8, 'admin.ekstrakurikules.index', 'ekstrakurikuler', 'web', '2023-12-26 09:49:51', NULL),
(9, 'admin.fasilitas.index', 'fasilitas', 'web', '2023-12-26 09:49:51', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
,`kelas` bigint(20) unsigned
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
  `username` varchar(255) NOT NULL,
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

INSERT INTO `tbl_akuns` (`id`, `user_id`, `username`, `nama_lengkap`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, NULL, 'cici', 'Ceycilia', 'cici@admin.com', '$2y$12$0RP.mY.Ke1KYTcvh4D5IE.IV8cO2aTdi5IfsGHVBN8Yu9zBAKBGYi', 'Admin', '2023-12-05 18:49:34', NULL),
(2, NULL, 'admin2', 'admin2', 'admin@test.com', '$2y$12$0RP.mY.Ke1KYTcvh4D5IE.IV8cO2aTdi5IfsGHVBN8Yu9zBAKBGYi', 'Admin', '2023-12-05 18:50:44', NULL),
(3, NULL, 'Admin', 'Admin', 'admin@test.com', '$2y$12$0RP.mY.Ke1KYTcvh4D5IE.IV8cO2aTdi5IfsGHVBN8Yu9zBAKBGYi', 'Admin', '2023-12-14 10:04:36', '2023-12-14 10:04:36'),
(4, 8, 'Guru', 'Guru', 'guru@test.com', '$2y$12$0RP.mY.Ke1KYTcvh4D5IE.IV8cO2aTdi5IfsGHVBN8Yu9zBAKBGYi', 'Guru', '2023-12-14 10:04:36', '2023-12-14 10:04:36'),
(5, 999999, 'Siswa1', 'Siswa', 'siswa@test.com', '$2y$12$0RP.mY.Ke1KYTcvh4D5IE.IV8cO2aTdi5IfsGHVBN8Yu9zBAKBGYi', 'Siswa', '2023-12-14 10:04:36', '2023-12-14 10:04:36');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_beritas`
--

CREATE TABLE `tbl_beritas` (
  `id_berita` bigint(20) UNSIGNED NOT NULL,
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
  `id_mapel` bigint(20) UNSIGNED NOT NULL,
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
  `id_ekskul` bigint(20) UNSIGNED NOT NULL,
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
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_ekskul` bigint(20) UNSIGNED NOT NULL,
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
  `id_fasilitas` bigint(20) UNSIGNED NOT NULL,
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
  `id_guru` bigint(20) UNSIGNED NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `nama_guru` varchar(255) NOT NULL,
  `gelar_guru` varchar(100) DEFAULT NULL,
  `ket_guru` varchar(100) NOT NULL,
  `status_guru` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_gurus`
--

INSERT INTO `tbl_gurus` (`id_guru`, `user_id`, `nama_guru`, `gelar_guru`, `ket_guru`, `status_guru`, `created_at`) VALUES
(1, 'ab557138-70cf-4f83-a75a-5316213adb9a', 'Linda Siti Zulaikha', 'S.Pd', 'Non-PNS', 'Aktif', NULL),
(2, '3a3f150a-921f-4da8-8db8-dfadb9e21704', 'Siti Warohmah', NULL, 'Non-PNS', 'Aktif', NULL),
(3, 'b5e1574f-8e8b-47ca-9502-6be88db66d5a', 'Andi Putra Batubara', NULL, 'Non-PNS', 'Aktif', NULL),
(4, '487cfb08-7121-4a0d-84ad-03c61b125c92', 'Ali Rahman', 'S.Pd.I', 'Non-PNS', 'Aktif', NULL),
(5, '5a830f2d-eed3-4d3e-9eb9-52f477cea196', 'Chairul Azmi Lubis', 'S.Pd', 'Non-PNS', 'Aktif', NULL),
(6, '6005d583-dd67-4b37-8d56-0b369fe466be', 'Riri Andrian', 'S.Pd', 'Non-PNS', 'Aktif', NULL),
(7, '30e884a1-8398-4b40-a995-537159fc928b', 'Sri Wedari', 'S.Pd', 'Non-PNS', 'Aktif', NULL),
(8, 'f09727a5-aad1-493c-87e0-78289a1017d9', 'Nurlia Ayuni', 'S.Ag', 'Non-PNS', 'Aktif', NULL),
(9, 'de33bd14-4be6-498f-a80f-c89487b04f6c', 'Mariani', 'S.Pd.I', 'Non-PNS', 'Aktif', NULL),
(10, '5e4cefe4-d24b-443c-b90c-a8881e2a8dfc', 'Nahfazul Fauziah Harahap', 'S.Pd', 'Non-PNS', 'Aktif', NULL),
(11, '7e840fe0-a7a4-4007-b6ff-bfc4a0b9a24a', 'Salmah', 'S.Ag', 'Non-PNS', 'Aktif', NULL),
(12, '43e0d18f-e558-4e2c-85d8-ade37891ad56', 'Susilawati', 'S.Ag', 'Non-PNS', 'Aktif', NULL),
(13, '81f0575a-babd-4114-86db-1ee183173f3b', 'Laily Ramadhani', 'S.Pd, M.Ak', 'Non-PNS', 'Aktif', NULL),
(14, 'e3d35d40-9d56-4d2e-b789-7639dd3da068', 'Nuranisa', 'S.Pd.I', 'Non-PNS', 'Aktif', NULL),
(15, 'b9a9134b-6ebf-4e00-887d-eccc5a825109', 'Rudi Ahmad', 'S.Pd.I', 'Non-PNS', 'Aktif', NULL),
(16, 'fb99357e-a162-4c19-a2d9-aac3e1d6d6b9', 'Seri Wahyuni', 'S.Pd.I', 'Non-PNS', 'Aktif', NULL),
(17, '9a7aef3e-2c65-4bc0-bb2b-bcef6402f7af', 'Masitah', 'S.Pd.I', 'Non-PNS', 'Aktif', NULL),
(18, '4d1289ec-59df-4cdb-9db9-0cf6233fca60', 'Qatrunnada', 'S.Pd.I', 'Non-PNS', 'Aktif', NULL),
(19, '0a4a121e-8dc9-4c25-aa1e-c05184fdecad', 'Maimunah. Bb', 'S.Sos', 'Non-PNS', 'Aktif', NULL),
(20, '7ea3bb16-ce26-4cc3-a9dd-86eee2b503b9', 'Nuraini', 'SE', 'Non-PNS', 'Aktif', NULL),
(21, '2da75f18-9e09-4649-97e1-ea600e266183', 'Alvy Hayati Nur', NULL, 'Non-PNS', 'Aktif', NULL);

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
  `id_kelas` bigint(20) UNSIGNED NOT NULL,
  `tingkat_kelas` varchar(10) NOT NULL DEFAULT '1',
  `nama` varchar(255) NOT NULL,
  `tahun_ajaran_id` bigint(20) UNSIGNED NOT NULL,
  `wali_kelas` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_kelas`
--

INSERT INTO `tbl_kelas` (`id_kelas`, `tingkat_kelas`, `nama`, `tahun_ajaran_id`, `wali_kelas`, `created_at`, `updated_at`) VALUES
(1, '1', 'I-A', 1, 7, NULL, NULL),
(2, '1', 'I-B', 1, 9, NULL, NULL),
(3, '1', 'I-C', 1, 17, NULL, NULL),
(4, '2', 'II-A', 1, 10, NULL, NULL),
(5, '2', 'II-B', 1, 9, NULL, NULL),
(6, '2', 'II-C', 1, 11, NULL, NULL),
(7, '3', 'III-A', 1, 8, NULL, NULL),
(8, '3', 'III-B', 1, 12, NULL, NULL),
(9, '4', 'IV-A', 1, 21, NULL, NULL),
(10, '4', 'IV-B', 1, 13, NULL, NULL),
(11, '4', 'IV-C', 1, 15, NULL, NULL),
(12, '5', 'V-A', 1, 14, NULL, NULL),
(13, '5', 'V-B', 1, 15, NULL, NULL),
(14, '5', 'V-C', 1, 19, NULL, NULL),
(15, '6', 'VI-A', 1, 18, NULL, NULL),
(16, '6', 'VI-B', 1, 20, NULL, NULL);

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
-- Table structure for table `tbl_kkm_mapel`
--

CREATE TABLE `tbl_kkm_mapel` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mapel_id` bigint(20) UNSIGNED NOT NULL,
  `kelas_id` bigint(20) UNSIGNED NOT NULL,
  `kkm` int(11) NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_mapel_gurus`
--

CREATE TABLE `tbl_mapel_gurus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_guru` bigint(20) UNSIGNED NOT NULL,
  `id_mapel` bigint(20) UNSIGNED NOT NULL
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
-- Table structure for table `tbl_mapping_mapel`
--

CREATE TABLE `tbl_mapping_mapel` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mapel_id` bigint(20) UNSIGNED NOT NULL,
  `kelompok` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_urut` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_nilais`
--

CREATE TABLE `tbl_nilais` (
  `id_nilai` bigint(20) UNSIGNED NOT NULL,
  `nisn_siswa` bigint(20) UNSIGNED NOT NULL,
  `jenis_nilai` varchar(255) NOT NULL,
  `id_mapel` bigint(20) UNSIGNED NOT NULL,
  `id_guru` bigint(20) UNSIGNED NOT NULL,
  `nilai` double NOT NULL,
  `tahun_ajaran` varchar(100) NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_nilais`
--

INSERT INTO `tbl_nilais` (`id_nilai`, `nisn_siswa`, `jenis_nilai`, `id_mapel`, `id_guru`, `nilai`, `tahun_ajaran`, `created_by`, `created_at`) VALUES
(1, 999999, 'uh1', 2, 21, 15, '', 0, NULL);

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
  `id_pegawai` bigint(20) UNSIGNED NOT NULL,
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
-- Table structure for table `tbl_pembelaran`
--

CREATE TABLE `tbl_pembelaran` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kelas_id` bigint(20) UNSIGNED NOT NULL,
  `mapel_id` bigint(20) UNSIGNED NOT NULL,
  `guru_id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_prestasis`
--

CREATE TABLE `tbl_prestasis` (
  `id_prestasi` bigint(11) UNSIGNED NOT NULL,
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
  `mapel_guru` bigint(20) UNSIGNED NOT NULL,
  `kelas` bigint(20) UNSIGNED NOT NULL,
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
  `user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nisn` bigint(20) UNSIGNED NOT NULL,
  `nipd` bigint(20) UNSIGNED NOT NULL,
  `nama_siswa` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jk_siswa` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `agama_siswa` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tempat_lahir` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `status_siswa` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_kelas` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_siswas`
--

INSERT INTO `tbl_siswas` (`user_id`, `nisn`, `nipd`, `nama_siswa`, `jk_siswa`, `agama_siswa`, `tempat_lahir`, `tanggal_lahir`, `status_siswa`, `id_kelas`, `created_at`, `updated_at`) VALUES
('9a73e442-573b-4e7d-93fb-5dc31dbd5673', 999999, 999999, 'adam', 'L', 'islam', 'Batam', '2002-12-04', 'Aktif', 16, NULL, '2023-12-27 07:45:21'),
('ed0bc63a-0d36-406b-b8f3-e2e0a80c0920', 111172557, 4412, 'Dilla Mahera\r\n', 'P', 'islam', 'sigli\r\n', '2011-06-21', 'Aktif', 15, NULL, '2023-12-27 07:45:22'),
('9554c6e0-abc6-494c-aec6-75de4ba9fee7', 112403313, 4464, 'Reza Dwi Andika', 'L', 'islam', 'Laut Dendang', '2011-12-31', 'Aktif', 16, NULL, '2023-12-27 07:45:22'),
('e91f706b-405f-45c3-95e4-62164ec63dfa', 112415392, 4402, 'Alief Frandika', 'L', 'islam', 'kolam', '2011-12-06', 'Aktif', 16, NULL, '2023-12-27 07:45:22'),
('a9296eb5-2114-488b-bd45-5e069122101a', 112464967, 4465, 'Ridhuan', 'L', 'islam', 'Medan', '2011-12-27', 'Aktif', 16, NULL, '2023-12-27 07:45:22'),
('6c9688ad-1f46-49ab-a86a-16d9c994327f', 112919751, 4427, 'KAMAL MAULANA HARAHAP\r\n', 'L', 'islam', 'BANDAR KHALIPAH\r\n', '2011-05-05', 'Aktif', 15, NULL, '2023-12-27 07:45:23'),
('1e04db66-104c-4369-9eac-34512a4fd800', 113327378, 4414, 'Dini Anggraini', 'P', 'islam', 'Medan', '2011-11-26', 'Aktif', 16, NULL, '2023-12-27 07:45:23'),
('8f008a18-8c61-49c5-8eea-7c62eecb3ec0', 116826680, 4469, 'Risky Aditia Nugroho', 'L', 'islam', 'Laut Dendang', '2011-05-26', 'Aktif', 16, NULL, '2023-12-27 07:45:23'),
('9bdf9be8-f8fe-48f3-9976-832fcc722e90', 117461542, 4420, 'Fadillah Ahmad', 'L', 'islam', 'Laut Dendang', '2011-12-01', 'Aktif', 16, NULL, '2023-12-27 07:45:24'),
('d7b89f49-d4f8-4c94-b59c-439ab6df1711', 118969993, 4397, 'Adetya\r\n', 'L', 'islam', 'medan\r\n', '2011-08-04', 'Aktif', 15, NULL, '2023-12-27 07:45:24'),
('dddfee07-c905-434a-9e46-ea19a8cc6ba2', 121086551, 4999, 'KINANTI PUTRI DWI MAULANA\r\n', 'P', 'islam', 'MEDAN\r\n', '2012-11-29', 'Aktif', 16, NULL, '2023-12-27 07:45:24'),
('bd3b7bbe-9763-4153-be6e-adcd289cf4ff', 121302996, 4425, 'Irvan Khadavi', 'L', 'islam', 'Laut Dendang', '2012-10-09', 'Aktif', 16, NULL, '2023-12-27 07:45:25'),
('36d1623e-7e73-4960-a114-2e52cbaebf39', 121427032, 4400, 'Alfiani Nowilia Safitri', 'P', 'islam', 'Laut Dendang', '2012-11-06', 'Aktif', 16, NULL, '2023-12-27 07:45:25'),
('0fa40d3a-d3f6-4a12-a6f3-e70bf1404ead', 121647881, 4423, 'Harnita Nadya Auliyah\r\n', 'P', 'islam', 'batam\r\n', '2012-05-12', 'Aktif', 15, NULL, '2023-12-27 07:45:25'),
('a30f4502-a03d-46f6-b4f5-6602f464274b', 121684678, 4399, 'Alfath Aprilio\r\n', 'L', 'islam', 'medan\r\n', '2012-05-09', 'Aktif', 15, '2023-12-19 04:13:24', '2023-12-27 07:45:25'),
('949d3a5e-d985-41b5-866e-1c0f8f11135f', 121918089, 4430, 'M. Ahwan Aldiansyah\r\n', 'L', 'islam', 'laut dendang\r\n', '2012-07-27', 'Aktif', 15, NULL, '2023-12-27 07:45:26'),
('8442317e-d5a2-4c8a-819c-dc2c5dff1c4c', 121965764, 4555, 'Putri Alya BR Pane\r\n', 'P', 'islam', 'MEDAN\r\n', '2011-12-01', 'Aktif', 13, NULL, '2023-12-27 07:45:26'),
('18b19afe-496a-4edc-a085-34e4b8383e42', 122216957, 4873, 'Afika Fitria', 'P', 'islam', 'Pisang Pala', '2012-06-20', 'Aktif', 6, NULL, '2023-12-27 07:45:26'),
('4c84d253-ff69-4f26-8735-861f33aa829e', 122285445, 4457, 'Raffiqa Radhila', 'P', 'islam', 'Medan', '2012-05-18', 'Aktif', 16, NULL, '2023-12-27 07:45:26'),
('18aff587-55e1-411a-91d1-dad5b2cee055', 122572975, 4431, 'M. Arya Afandi\r\n', 'L', 'islam', 'laut dendang\r\n', '2012-05-27', 'Aktif', 14, NULL, '2023-12-27 07:45:27'),
('75193eaa-1b01-4033-ba28-fddfa10f3f54', 122829943, 4405, 'Amelia Syahfitri', 'P', 'islam', 'Laut Dendang', '2012-03-20', 'Aktif', 16, NULL, '2023-12-27 07:45:27'),
('0a2ba194-85f1-4167-8884-10e69d091eb3', 123011525, 4475, 'Vindeza Cipta', 'L', 'islam', 'Medan', '2012-05-02', 'Aktif', 16, NULL, '2023-12-27 07:45:27'),
('3d312830-1253-484e-92f8-aa6a23203a52', 123219434, 4419, 'Fadhil Syahnata', 'L', 'islam', 'Laut Dendang', '2012-01-01', 'Aktif', 16, NULL, '2023-12-27 07:45:28'),
('02c17f1f-505b-468d-a751-922dd766069e', 124012757, 4339, 'Muhammad Abil', 'L', 'islam', 'Medan Estate', '2012-08-09', 'Aktif', 16, NULL, '2023-12-27 07:45:28'),
('55303be1-2045-4d1b-a8c2-44c98e7890ee', 124521764, 4429, 'M. Aditya\r\n', 'L', 'islam', 'banda aceh\r\n', '2012-03-06', 'Aktif', 15, NULL, '2023-12-27 07:45:28'),
('f1d1111d-b389-42b6-802b-2e58bfe3b9d7', 125024029, 4466, 'Ririn Dwi Yanti', 'P', 'islam', 'Laut Dendang', '2012-12-14', 'Aktif', 16, NULL, '2023-12-27 07:45:29'),
('88875259-b94f-4ce5-be8f-828c6b2caf38', 125077963, 4463, 'Revan Syaban Albuqohri', 'L', 'islam', 'Laut Dendang', '2012-06-27', 'Aktif', 16, NULL, '2023-12-27 07:45:29'),
('4ed21340-c456-4366-b6da-59303fe8d662', 125349355, 4474, 'Theo Didik Pratama', 'L', 'islam', 'Bandar Setia', '2012-04-04', 'Aktif', 16, NULL, '2023-12-27 07:45:29'),
('080dd632-e102-4421-9596-065765a14ac3', 125523717, 4462, 'Rapa Fanduwi', 'L', 'islam', 'Batubara', '2012-01-16', 'Aktif', 16, NULL, '2023-12-27 07:45:29'),
('705265ce-9385-42b8-891f-9510d138db74', 125578023, 4437, 'Mhd. Rafa Naufal Kamil', 'L', 'islam', 'Medan', '2012-06-29', 'Aktif', 16, NULL, '2023-12-27 07:45:30'),
('b8a723ee-ec63-4243-a20b-b8f857edad32', 125619208, 4417, 'Fachri Ramadhan\r\n', 'L', 'islam', 'medan\r\n', '2012-08-16', 'Aktif', 15, NULL, '2023-12-27 07:45:30'),
('bf13bc70-07ae-4caa-8795-8f9e06e3eda7', 126132073, 4478, 'Yoga Pratama', 'L', 'islam', 'Batubara', '2012-04-17', 'Aktif', 16, NULL, '2023-12-27 07:45:30'),
('a41ca3c3-b059-4bcc-94b4-6fb7fc9d5f95', 126487608, 5026, 'M Ikhsan Al Ragil\r\n', 'L', 'islam', 'Deli Serdang\r\n', '2012-06-28', 'Aktif', 13, NULL, '2023-12-27 07:45:31'),
('d5017c8e-71e4-4359-9455-72c0528d31b8', 126825440, 4591, 'Zakhy Ferdiansyah\r\n', 'L', 'islam', 'Medan\r\n', '2012-09-18', 'Aktif', 13, NULL, '2023-12-27 07:45:31'),
('3e6d938c-6744-4add-9378-7c528e39f876', 126889152, 4458, 'Raiqah Rachmad Nasution', 'P', 'islam', 'Medan', '2012-10-02', 'Aktif', 16, NULL, '2023-12-27 07:45:31'),
('21b8acb1-a5d2-4806-bf41-a88262f4685a', 127210210, 4450, 'Nazwa Lutfiyah', 'P', 'islam', 'Medan', '2012-09-17', 'Aktif', 16, NULL, '2023-12-27 07:45:31'),
('85933bf7-dda6-4f77-b4bd-7d161de0d9e6', 127511284, 4410, 'Azhari Alif Andika\r\n', 'L', 'islam', 'medan\r\n', '2012-02-02', 'Aktif', 15, NULL, '2023-12-27 07:45:32'),
('b4442ddd-e980-472b-845f-5e334b9aff65', 127673587, 4645, 'DWI ARYA PRATAMA\r\n', 'L', 'islam', 'MEDAN\r\n', '2012-09-09', 'Aktif', 11, NULL, '2023-12-27 07:45:32'),
('909ff0a8-4837-4a15-bb9b-c7f75c1d7608', 127823420, 4526, 'Kaisa Devilia', 'P', 'islam', 'Laut Dendang', '2012-11-19', 'Aktif', 12, NULL, '2023-12-27 07:45:32'),
('07ddbfd9-92f0-447b-8d56-eb3e83f85d44', 127949295, 4735, 'Bagus Prasetyo', 'L', 'islam', 'Langkat', '2012-06-12', 'Aktif', 16, NULL, '2023-12-27 07:45:33'),
('22362aad-7ba0-4155-b2fa-3c852dfb5715', 128005889, 4418, 'Fadhil Guntara Matondang\r\n', 'L', 'islam', 'laut dendang\r\n', '2012-10-13', 'Aktif', 15, NULL, '2023-12-27 07:45:33'),
('e894f7dd-438c-4cb0-bcf0-3d52609b98bb', 128283086, 4422, 'Hardiansyah Reyhan Pratama\r\n', 'L', 'islam', 'laut dendang\r\n', '2012-03-02', 'Aktif', 15, NULL, '2023-12-27 07:45:33'),
('8b05d144-000f-44a0-b002-859f522a8716', 128487431, 4403, 'Alief Pratama Silalahi', 'L', 'islam', 'Medan', '2012-07-16', 'Aktif', 16, NULL, '2023-12-27 07:45:33'),
('296b3133-e1fd-4a53-8275-22ec9498d402', 128526738, 4436, 'Mhd. Alda Wira', 'L', 'islam', 'Medan Estate', '2012-06-23', 'Aktif', 16, NULL, '2023-12-27 07:45:34'),
('0baef1ac-5328-4407-bfd3-0e9c8c3cd493', 128766400, 4426, 'Jelita Mutiara Putri\r\n', 'P', 'islam', 'laut dendang\r\n', '2012-08-23', 'Aktif', 15, '2023-11-03 10:03:31', '2023-12-27 07:45:34'),
('7ad6829c-017f-4062-bf5b-7e851a0477a7', 129263104, 4416, 'DWI ATTIQAAH PUTRI\r\n', 'P', 'islam', 'LAUT DENDANG\r\n', '2012-07-08', 'Aktif', 15, NULL, '2023-12-27 07:45:34'),
('289831bc-6cc5-4bc1-aab1-2e49d5fb0597', 129431541, 4439, 'Muhammad Azzam', 'L', 'islam', 'Medan', '2012-01-04', 'Aktif', 16, NULL, '2023-12-27 07:45:34'),
('91ec6cbb-199d-46ee-8836-fe240d9a845b', 129498271, 4533, 'Muhammad Abdul Dzakiy', 'L', 'islam', 'Bangun Rejo', '2012-12-31', 'Aktif', 12, NULL, '2023-12-27 07:45:35'),
('edba05d4-fac6-402f-bd81-f4ace625cafc', 129581447, 4470, 'Riziq Akbar', 'L', 'islam', 'Laut Dendang', '2012-05-10', 'Aktif', 16, NULL, '2023-12-27 07:45:35'),
('7da1af71-2a73-4108-a162-f77e127ae3b5', 129678964, 4455, 'Prabu Arya Rasidin Ahmad', 'L', 'islam', 'Sei Rotan', '2012-02-27', 'Aktif', 16, NULL, '2023-12-27 07:45:35'),
('5d242fb0-9185-47db-ae04-a57a5b663217', 129743302, 5023, 'Cut Nisyah Aulia\r\n', 'P', 'islam', 'Medan\r\n', '2012-12-12', 'Aktif', 13, NULL, '2023-12-27 07:45:36'),
('43f7b8fb-62ec-4196-81ce-80ef831ea40f', 131273654, 4659, 'Hazizah\r\n', 'P', 'islam', 'Medan\r\n', '2013-10-10', 'Aktif', 9, NULL, '2023-12-27 07:45:36'),
('be0ddf04-c36f-471d-afb9-0ee2ffc75154', 131387655, 4531, 'Mada Al Fatih', 'L', 'islam', 'Tembung', '2013-07-20', 'Aktif', 12, NULL, '2023-12-27 07:45:36'),
('fb39ac4b-76eb-414a-9235-55282412c712', 132029823, 4628, 'Amar Joyo Handoko', 'L', 'islam', 'Langkat', '2013-10-20', 'Aktif', 10, NULL, '2023-12-27 07:45:36'),
('2811b79c-b7d5-4218-9e7a-c6b1cc168d4d', 132126026, 4706, 'Rivansyah Dewa\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-04-11', 'Aktif', 11, NULL, '2023-12-27 07:45:37'),
('b1f5c508-4787-42f4-b4a9-983b52351946', 133157633, 5022, 'Alifia Aishyah Zahra\r\n', 'P', 'islam', 'Langkat\r\n', '2013-11-11', 'Aktif', 13, NULL, '2023-12-27 07:45:37'),
('b5845540-6542-469f-87d9-408cd61fb9a1', 133408195, 4514, 'Cahaya Balqis\r\n', 'P', 'islam', 'Medan\r\n', '2013-06-01', 'Aktif', 14, NULL, '2023-12-27 07:45:37'),
('33252679-216d-4b36-9592-7c4fb7fd39f4', 133482268, 4518, 'Dirga Pramana Putra', 'L', 'islam', 'Laut Dendang', '2013-06-18', 'Aktif', 12, NULL, '2023-12-27 07:45:38'),
('0f1c524e-c9cf-448e-99ec-63c6070d237d', 134370080, 4508, 'Armada Jaya Hadi Lubis\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-10-18', 'Aktif', 14, NULL, '2023-12-27 07:45:38'),
('1ef49c9f-07b5-4bd7-ae12-ddd20f4aa8c6', 134549386, 5020, 'KESYA NABILA PUTRI\r\n', 'P', 'islam', 'LAUT DENDANG\r\n', '2013-06-18', 'Aktif', 13, NULL, '2023-12-27 07:45:38'),
('bbb1988e-52c8-4fa3-8265-6f669d679845', 136321102, 4496, 'Adibah Mey Safrina', 'P', 'islam', 'Laut Dendang', '2013-05-26', 'Aktif', 12, NULL, '2023-12-27 07:45:38'),
('3a81d9da-3147-491c-846d-fcf4be161219', 136979298, 5011, 'Audy Angkasa\r\n', 'P', 'islam', 'Medan\r\n', '2015-10-09', 'Aktif', 7, NULL, '2023-12-27 07:45:39'),
('abfe3ccc-ae58-41ea-925d-c9e687b4dd25', 137746589, 4520, 'Eza Al Vino', 'L', 'islam', 'Laut Dendang', '2013-09-21', 'Aktif', 12, NULL, '2023-12-27 07:45:39'),
('d0b122c9-e54b-4e36-a1d6-abce560679e5', 137862056, 4563, 'Rara Irdina', 'P', 'islam', 'Kota Tengah', '2013-04-22', 'Aktif', 12, NULL, '2023-12-27 07:45:39'),
('b417a023-0d4d-4b1a-b6e4-e9a933b80f67', 138023318, 4576, 'Suci Amelia\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2013-05-10', 'Aktif', 13, NULL, '2023-12-27 07:45:40'),
('6ee22a26-d816-47cf-a1c9-0de39f607520', 138796352, 4881, 'Alfathan Fredy Asyah', 'L', 'islam', 'Binjai', '2015-12-15', 'Aktif', 5, NULL, '2023-12-27 07:45:40'),
('d32c88d4-7a78-4f88-8fd2-52c3ef5a9277', 139760118, 4513, 'Bunga Khairunnisa', 'P', 'islam', 'Medan', '2013-10-29', 'Aktif', 12, NULL, '2023-12-27 07:45:40'),
('3b4fb793-bb27-437c-92fc-c5ae10a643d0', 141415799, 4712, 'Sheddiq Raffa Purnama Manurung\r\n', 'L', 'islam', 'Medan\r\n', '2014-02-27', 'Aktif', 11, NULL, '2023-12-27 07:45:40'),
('69527ac7-0a9a-4a09-9c4c-87678be5f0b8', 141421503, 4637, 'Azka Huzaifah', 'L', 'islam', 'Langkat', '2014-08-11', 'Aktif', 10, NULL, '2023-12-27 07:45:41'),
('585a30a3-ec8a-4b1a-964c-f682eedeab18', 141722399, 4714, 'Syaqilla Dwi Almira\r\n', 'P', 'islam', 'Medan\r\n', '2014-05-29', 'Aktif', 11, NULL, '2023-12-27 07:45:41'),
('91deb553-7565-4a94-83f8-7f53287cea1f', 142407474, 4656, 'Habibi\r\n', 'L', 'islam', 'Medan\r\n', '2014-04-10', 'Aktif', 10, NULL, '2023-12-27 07:45:41'),
('f5971448-5160-477a-aea7-6a94a3194a7b', 142522058, 4642, 'Devila Ramadhani\r\n', 'P', 'islam', 'Medan\r\n', '2014-07-05', 'Aktif', 7, NULL, '2023-12-27 07:45:41'),
('ade77dc8-e216-4f23-9cb5-5dcd87d6e605', 142817972, 4673, 'Muhammad Aditya\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2014-07-24', 'Aktif', 11, NULL, '2023-12-27 07:45:42'),
('755aaf5b-3abd-43f0-a213-c087bd01470e', 143098302, 4630, 'Anhu Khairi Ardhin\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2014-10-30', 'Aktif', 9, NULL, '2023-12-27 07:45:42'),
('3b5fd561-4f84-422c-8c83-8b45a8416d81', 143627734, 4688, 'Nayra Ramadhani\r\n', 'P', 'islam', 'Bandar Khalipah\r\n', '2014-07-14', 'Aktif', 11, NULL, '2023-12-27 07:45:42'),
('3bb0f527-0344-4649-bce9-1dd88c7a296d', 144539399, 4661, 'Kirana Kellen\r\n', 'P', 'islam', 'Prabumulih\r\n', '2014-07-05', 'Aktif', 9, NULL, '2023-12-27 07:45:43'),
('20587ce4-af8f-4b01-8874-289fa596e25d', 147629217, 4679, 'Muhammad Riyan Ramadan\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2014-06-26', 'Aktif', 9, NULL, '2023-12-27 07:45:43'),
('ad830ca1-6342-4ea9-aa1f-6e74e5d6a180', 147840265, 4814, 'Nabilla Aprila\r\n', 'P', 'islam', 'Medan\r\n', '2014-04-26', 'Aktif', 8, NULL, '2023-12-27 07:45:43'),
('f241bff4-2164-4036-aa47-8ec669fd3f70', 148828864, 4681, 'Nadien Putri Amelia\r\n', 'P', 'islam', 'Medan\r\n', '2014-06-08', 'Aktif', 11, NULL, '2023-12-27 07:45:43'),
('ed12f075-0fa3-421d-83a6-86dc27a7fe99', 152722565, 4805, 'M. Zulfikri\r\n', 'L', 'islam', 'Medan\r\n', '2015-01-25', 'Aktif', 7, NULL, '2023-12-27 07:45:44'),
('eeb66afc-b3b1-4161-a0d7-f7c835f14a77', 159921812, 4884, 'Amira', 'P', 'islam', 'Medans', '2015-09-26', 'Aktif', 4, '2023-12-06 19:26:02', '2023-12-27 07:45:44'),
('8bfd6ac3-042b-45d6-acf7-75ba601481f9', 3104413859, 5012, 'Andika Syaputra\r\n', 'P', 'islam', 'Medan\r\n', '2010-05-27', 'Aktif', 7, NULL, '2023-12-27 07:45:44'),
('be020121-c531-48f5-85d2-6da550fe456a', 3110560808, 4409, 'AULIA NATASYA\r\n', 'P', 'islam', 'SIDEMPUAN\r\n', '2011-09-11', 'Aktif', 15, NULL, '2023-12-27 07:45:45'),
('1f960635-1f05-49f8-aa8d-67f034bc9566', 3110720379, 5006, 'Kanaya Azzura Harahap\r\n', 'P', 'islam', 'Medan\r\n', '2011-09-19', 'Aktif', 14, NULL, '2023-12-27 07:45:45'),
('7ef5eef1-794a-4a27-8909-7e07bf467774', 3112883586, 4411, 'Bima Batara Al Sani\r\n', 'L', 'islam', 'Bandar Setia\r\n', '2011-11-07', 'Aktif', 15, NULL, '2023-12-27 07:45:45'),
('bafb410c-130b-4b47-a281-d65721184c6d', 3112936976, 5021, 'RANGGA PRATAMA\r\n', 'L', 'islam', 'Bandar Setia\r\n', '2012-12-27', 'Aktif', 13, NULL, '2023-12-27 07:45:45'),
('bdcf9512-b401-4df3-9860-c4a2adfd40ad', 3114993252, 4408, 'Assifa Syakira\r\n', 'P', 'islam', 'medan\r\n', '2011-12-06', 'Aktif', 15, NULL, '2023-12-27 07:45:46'),
('a58d2b0b-ab0b-411f-9730-4459034d43cf', 3115923861, 4556, 'Putri Anita\r\n', 'P', 'islam', 'Medan\r\n', '2011-10-30', 'Aktif', 13, NULL, '2023-12-27 07:45:46'),
('d047ad21-a12d-484d-a0d0-607c5993500b', 3116729075, 4461, 'Rangga Ramadhan Pangaribuan', 'L', 'islam', 'Bandar Setia', '2011-08-12', 'Aktif', 16, NULL, '2023-12-27 07:45:46'),
('be6af6da-eccc-4301-a407-d92794988b1c', 3118799397, 4993, 'Inayah Alifia Syachrani\r\n', 'P', 'islam', 'Medan\r\n', '2011-11-04', 'Aktif', 15, NULL, '2023-12-27 07:45:47'),
('fefe8fe9-3616-406d-ac4b-f9792fe95751', 3121142720, 4521, 'Fahmi Fahrezi', 'L', 'islam', 'Medan Estate', '2012-07-26', 'Aktif', 12, NULL, '2023-12-27 07:45:47'),
('8e4373a0-a932-4540-ae09-c3faa784925f', 3121535615, 5027, 'Al Mushawwiru Zaky\r\n', 'L', 'islam', 'Medan Estate\r\n', '2012-12-26', 'Aktif', 13, NULL, '2023-12-27 07:45:47'),
('9817bf94-8ffd-4b0c-b5cd-75d03c165263', 3122517292, 4406, 'ANAR KHY SUHARNAN\r\n', 'L', 'islam', 'SIBARUANG\r\n', '2012-06-03', 'Aktif', 15, NULL, '2023-12-27 07:45:47'),
('9440566c-80b2-4f6e-a569-f9f1b8f9a208', 3123605240, 4535, 'Muhammad Al Hafiizhi', 'L', 'islam', 'Tembung', '2012-12-31', 'Aktif', 12, NULL, '2023-12-27 07:57:09'),
('e02d3339-308b-4efa-b920-803dcd5ab23a', 3123755937, 4424, 'Indri Aulia', 'P', 'islam', 'Medan', '2012-01-24', 'Aktif', 16, NULL, '2023-12-27 07:45:48'),
('92f0c6a0-1716-4f23-9670-1b662d7d031b', 3124420502, 4557, 'Putry Sry Rezeky', 'P', 'islam', 'Medan', '2012-12-30', 'Aktif', 12, NULL, '2023-12-27 07:45:48'),
('ec33a2df-ca5f-4eb4-8912-5e880b497170', 3124539802, 4527, 'Khairunisa\r\n', 'P', 'islam', 'Medan\r\n', '2012-12-25', 'Aktif', 13, NULL, '2023-12-27 07:45:49'),
('cb5cd791-6458-4632-b3f5-cd06278fc4d3', 3125307366, 4537, 'Muhammad Fajar Al Musanif\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2012-10-13', 'Aktif', 13, NULL, '2023-12-27 07:45:49'),
('c4e8ae18-7910-4bc4-8890-ca1da3220838', 3125384119, 4734, 'Abdi Riski Hamdani', 'L', 'islam', 'Sei Mencirim', '2012-06-01', 'Aktif', 16, NULL, '2023-12-27 07:45:49'),
('e068bf0a-de01-4e82-90fb-f35483f6b85e', 3125405642, 4337, 'Miftahul Jannah', 'P', 'islam', 'Laut Dendang', '2012-11-20', 'Aktif', 16, NULL, '2023-12-27 07:45:49'),
('e2518074-924c-4663-94a6-4247d381c2c6', 3126666968, 4401, 'Alfino Fajar Siregar', 'L', 'islam', 'Medan', '2012-04-05', 'Aktif', 16, NULL, '2023-12-27 07:45:50'),
('04c9cb9b-4d7d-4148-a72c-dea8ff048cdd', 3127308888, 4567, 'Rizki Ramadhani\r\n', 'L', 'islam', 'Bandar Khalipah\r\n', '2012-08-08', 'Aktif', 13, NULL, '2023-12-27 07:45:50'),
('caffd2cd-aca0-49a7-9c3b-dc29f48d1a11', 3127327970, 4995, 'Aziiz Jamiil\r\n', 'L', 'islam', 'Medan\r\n', '2012-02-06', 'Aktif', 15, NULL, '2023-12-27 07:45:50'),
('b78ed89a-d742-410d-9539-54fd28383ee3', 3127484318, 4511, 'Bintang Maharani\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2012-10-21', 'Aktif', 14, NULL, '2023-12-27 07:45:51'),
('cf0ac4e7-3f36-4745-976b-287785ed9549', 3127646794, 5024, 'Muhammad Rianda Pratama\r\n', 'L', 'islam', 'P. Johar\r\n', '2012-02-03', 'Aktif', 13, NULL, '2023-12-27 07:45:51'),
('6e28ca41-3def-4a41-8086-234686dbc464', 3128004903, 4562, 'Raisa Khairani', 'P', 'islam', 'Medan', '2012-12-26', 'Aktif', 12, NULL, '2023-12-27 07:45:51'),
('848a2424-c73b-4310-8e47-e2f3a9e9fe52', 3128821352, 4566, 'Riski Alpian\r\n', 'L', 'islam', 'Medan Estate\r\n', '2012-09-26', 'Aktif', 13, NULL, '2023-12-27 07:45:51'),
('8ed4f202-87a1-46ce-aa78-4de527e7373b', 3129164952, 5025, 'Ramadhan Husein\r\n', 'L', 'islam', 'Medan\r\n', '2012-11-12', 'Aktif', 10, NULL, '2023-12-27 07:45:52'),
('94a85cb6-707b-44d7-958e-74ee1a49b300', 3129445780, 4577, 'Suci Anggraini\r\n', 'P', 'islam', 'Medan\r\n', '2012-08-19', 'Aktif', 13, NULL, '2023-12-27 07:45:52'),
('4e062042-6e46-4fc6-8b63-1dc33ac910f8', 3129630694, 4545, 'Nabila Syakila Raya', 'P', 'islam', 'Laut Dendang', '2012-11-02', 'Aktif', 12, NULL, '2023-12-27 07:45:52'),
('2eb164fa-0aed-4e60-a7d8-e7183e0a901f', 3130098937, 4647, 'Egi Herdiansyah\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-11-21', 'Aktif', 9, NULL, '2023-12-27 07:45:53'),
('89979491-9991-4192-ad8c-9aed4ee5d8a9', 3131158265, 4584, 'Tri Aurel Sopadilla\r\n', 'P', 'islam', 'Medan\r\n', '2013-10-30', 'Aktif', 13, NULL, '2023-12-27 07:45:53'),
('16b5340f-b23b-481b-8946-35be1ba90fb5', 3131717373, 4582, 'Syifa Amelia\r\n', 'P', 'islam', 'Langkat\r\n', '2013-01-05', 'Aktif', 13, NULL, '2023-12-27 07:45:53'),
('ae34e80a-f742-4c91-bee8-f9a3826e6117', 3131974435, 4651, 'Farid Azhar Siregar\r\n', 'L', 'islam', 'Medan\r\n', '2013-08-05', 'Aktif', 9, NULL, '2023-12-27 07:45:53'),
('8338cb06-570e-4665-a38b-ee701eef50a2', 3132112194, 4640, 'Bimbi Alamsyah', 'L', 'islam', 'Medan', '2013-04-27', 'Aktif', 6, NULL, '2023-12-27 07:45:54'),
('0764bb95-8947-4e89-8b1e-c7b8745143e7', 3132177763, 4588, 'Wira Fitra Sanjaya\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-08-12', 'Aktif', 13, NULL, '2023-12-27 07:45:54'),
('7f7274c1-66f4-44ff-a5fb-40ea6eea2b7d', 3132213003, 4507, 'Aprilliya Gusnana Salim Bangun\r\n', 'P', 'islam', 'Medan\r\n', '2013-04-14', 'Aktif', 14, NULL, '2023-12-27 07:45:54'),
('3b1b3023-3f10-457b-bd22-32e06fa7cdc1', 3132214854, 4657, 'Hadiansyah Putra\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-10-10', 'Aktif', 11, NULL, '2023-12-27 07:45:54'),
('5d909267-85c3-4cf5-b7b6-5840f77b8953', 3132265729, 4698, 'Putri Anggraini\r\n', 'P', 'islam', 'Medan\r\n', '2013-12-04', 'Aktif', 7, NULL, '2023-12-27 07:45:55'),
('1cea14cb-734d-4004-a7ca-85d1f9726726', 3132352474, 5028, 'Sofiah Solehah\r\n', 'P', 'islam', 'Batam\r\n', '2013-01-01', 'Aktif', 13, NULL, '2023-12-27 07:45:55'),
('414205a8-fd0c-4ca2-bb45-3df1774cca5d', 3132359715, 4530, 'M. Bagas Prakoso Sahputra\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-04-12', 'Aktif', 14, NULL, '2023-12-27 07:45:55'),
('18aed56d-300d-4819-90fc-a28676b34f1e', 3132372335, 4538, 'Muhammad Farid Alfiqri\r\n', 'L', 'islam', 'Medan\r\n', '2013-07-02', 'Aktif', 13, NULL, '2023-12-27 07:45:56'),
('9a040918-adae-457c-92aa-a1d57432aa4c', 3132431803, 4522, 'Febryka Triani\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2013-03-18', 'Aktif', 13, NULL, '2023-12-27 07:45:56'),
('f16391d4-7c5f-418f-868b-06769bc63082', 3132770037, 4641, 'Dafa Pratama\r\n', 'L', 'islam', 'Lubuk Sabau\r\n', '2013-10-14', 'Aktif', 11, NULL, '2023-12-27 07:45:56'),
('bd19b41d-ae83-448f-b49f-b9c2360c3e0c', 3132949244, 4565, 'Rifqi\r\n', 'L', 'islam', 'Sampali\r\n', '2013-05-21', 'Aktif', 13, NULL, '2023-12-27 07:45:56'),
('11eb6110-c4e0-4aff-a35d-af7e5830d880', 3133071670, 4649, 'Fairah Naylatul Izzah Noor\r\n', 'P', 'islam', 'Bandar Setia\r\n', '2013-10-26', 'Aktif', 11, NULL, '2023-12-27 07:45:57'),
('f9292cf3-9e0a-431b-96bb-76f6203f53d2', 3133295476, 4655, 'Gilang Alviano\r\n', 'L', 'islam', 'Malaysia\r\n', '2013-07-15', 'Aktif', 11, NULL, '2023-12-27 07:45:57'),
('abecc602-05f3-4101-bd4e-0053d84ff62b', 3133302028, 4523, 'Fero Al Bian', 'L', 'islam', 'Laut Dendang', '2013-09-15', 'Aktif', 12, NULL, '2023-12-27 07:45:57'),
('a41f0da8-57f9-499b-b59d-32a25a0656d4', 3133379581, 4515, 'Cantika Putri Ajuini\r\n', 'P', 'islam', 'Medan\r\n', '2013-06-05', 'Aktif', 14, NULL, '2023-12-27 07:45:58'),
('56dcddda-f377-4abf-beb6-1bba53a90bc5', 3133726814, 4573, 'SANICAH', 'P', 'islam', 'Laut Dendang', '2013-04-24', 'Aktif', 12, NULL, '2023-12-27 07:45:58'),
('086c5601-dbb2-4cdf-8193-7e993a35c2a2', 3133968405, 4504, 'Alifa Rizka Khairani\r\n', 'P', 'islam', 'Medan\r\n', '2013-08-19', 'Aktif', 13, NULL, '2023-12-27 07:45:58'),
('5da57a04-755e-4370-a783-7020149b4754', 3134062366, 4625, 'Aisyah Safriani Harahap\r\n', 'P', 'islam', 'Tembung\r\n', '2013-11-09', 'Aktif', 11, NULL, '2023-12-27 07:45:58'),
('ce375c48-efdd-4af6-90fc-c3c317bb6803', 3134424647, 4680, 'Muhammad Saddam Shayfullah\r\n', 'L', 'islam', 'Medan\r\n', '2013-11-18', 'Aktif', 11, NULL, '2023-12-27 07:45:59'),
('60138ea0-c0d3-4eb2-9b10-3a4b0dc5a7cd', 3134831099, 4497, 'Afifah Mahira', 'P', 'islam', 'Medan Estate', '2013-10-19', 'Aktif', 12, NULL, '2023-12-27 07:45:59'),
('929dcd62-0783-42a0-8aa1-51ca5dd8ad50', 3135162157, 4509, 'Aufa Al Rasyid Lubis\r\n', 'L', 'islam', 'Medan\r\n', '2013-01-10', 'Aktif', 14, NULL, '2023-12-27 07:45:59'),
('a5ed8373-6253-4e8d-b193-d4537dba311a', 3135283395, 4653, 'Fitri Anjani\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2013-10-19', 'Aktif', 9, NULL, '2023-12-27 07:46:00'),
('10f1c84b-6e85-4055-b1e8-fbba8c52710c', 3135455225, 5005, 'JOREITA SEMBIRING\r\n', 'P', 'islam', 'MEDAN\r\n', '2013-07-27', 'Aktif', 14, NULL, '2023-12-27 07:46:00'),
('95727e5c-7c2d-440e-9573-d885d3730d8e', 3135712782, 4737, 'Alya Febiyanti\r\n\r\n', 'P', 'islam', 'Medan\r\n', '2013-02-16', 'Aktif', 14, NULL, '2023-12-27 07:46:00'),
('5b34c507-f803-4442-bdc9-b487ec439854', 3136017780, 4506, 'Anugrah Ferdiansyah\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-02-11', 'Aktif', 14, NULL, '2023-12-27 07:46:00'),
('e2219f3f-8c37-489a-a949-374820f8cd26', 3136182679, 4517, 'Daru Dwi Prawira\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-05-28', 'Aktif', 13, NULL, '2023-12-27 07:46:01'),
('367d42dd-1366-4c09-bd2e-f2bf997571e7', 3136222445, 2021, 'Rizky Perasetiyo\r\n', 'L', 'islam', 'Medan\r\n', '2013-03-06', 'Aktif', 8, NULL, '2023-12-27 07:46:01'),
('e67d643d-94ab-4b92-a976-2e11bcf6cd47', 3136417741, 4669, 'Mhd Farhan Nasution', 'L', 'islam', 'Medan', '2013-10-24', 'Aktif', 10, NULL, '2023-12-27 07:46:01'),
('fbf89cfd-13f1-46b0-9e70-36607051c05a', 3136489121, 5074, 'Fathan Anugerah Hubaini', 'L', 'islam', 'Medan', '2013-10-19', 'Aktif', 10, NULL, '2023-12-27 07:46:02'),
('40150946-c3a7-4943-8b79-ad0fc6c57ec8', 3136720456, 4662, 'Lasmana Prasetian\r\n', 'L', 'islam', 'Medan Estate\r\n', '2013-01-17', 'Aktif', 11, NULL, '2023-12-27 07:46:02'),
('967e8b44-1d80-485a-a8d0-46df756e3679', 3136929608, 4666, 'M. Yusuf Al-Syaidi', 'L', 'islam', 'Medan', '2013-11-05', 'Aktif', 10, NULL, '2023-12-27 07:46:02'),
('d08d5b90-dc83-49a4-9b45-529a12a61745', 3137062523, 4693, 'Nur Ain\r\n', 'P', 'islam', 'Medan\r\n', '2013-12-26', 'Aktif', 11, NULL, '2023-12-27 07:46:02'),
('e1a3735d-0306-4a30-982c-abb9b243c2ba', 3137094997, 4510, 'Ayunda Azzahra\r\n', 'P', 'islam', 'Medan\r\n', '2013-04-10', 'Aktif', 14, NULL, '2023-12-27 07:46:03'),
('2ab707c5-1be8-489c-9b28-929f0b5668d9', 3137311870, 4536, 'Muhammad Alduwin', 'L', 'islam', 'Laut Dendang', '2013-01-05', 'Aktif', 12, NULL, '2023-12-27 07:46:03'),
('7cdc9422-c761-48ce-9a00-82ccf9b27959', 3137590732, 4519, 'Dyo Febriansyah', 'L', 'islam', 'Laut Dendang', '2013-02-26', 'Aktif', 12, NULL, '2023-12-27 07:46:03'),
('3acd8aa5-8d46-4ea7-93bf-c60e59c1375f', 3137694925, 4578, 'Suci Dafina\r\n', 'P', 'islam', 'Binjai\r\n', '2013-08-07', 'Aktif', 13, NULL, '2023-12-27 07:46:04'),
('f7c73513-568e-475a-9b99-d1f52bec2eff', 3137799710, 4500, 'Aidil Akbar\r\n', 'L', 'islam', 'Medan\r\n', '2013-08-11', 'Aktif', 13, NULL, '2023-12-27 07:46:04'),
('32adf643-566b-471c-8d3e-c7134dd2b7a1', 3137831353, 4539, 'Muhammad Krisna\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2013-02-08', 'Aktif', 13, NULL, '2023-12-27 07:46:04'),
('a3478d0a-e0ec-4db0-8d37-0db3de9c0e1b', 3137875688, 4678, 'Muhammad Rasyid Septian', 'L', 'islam', 'Medan', '2013-09-20', 'Aktif', 10, NULL, '2023-12-27 07:46:04'),
('85eed457-061a-4458-a174-76c4bee86fa5', 3138010649, 4796, 'Hamilah Habsari\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2013-11-30', 'Aktif', 8, NULL, '2023-12-27 07:46:05'),
('f31c8225-da49-46ed-af13-d7cf336aa2c9', 3138193007, 4817, 'Nayla Yasmin\r\n', 'L', 'islam', 'Sampali\r\n', '2013-10-11', 'Aktif', 7, NULL, '2023-12-27 07:46:05'),
('fd2cbe73-9522-4b79-956a-f97c06ff8642', 3138367847, 4676, 'Muhammad Getar Syuhada', 'L', 'islam', 'Medan', '2013-12-27', 'Aktif', 10, NULL, '2023-12-27 07:46:05'),
('8de6c94f-199d-43f7-b96c-55c63b6ebd83', 3138689153, 4501, 'Aina Talita Zahran\r\n', 'P', 'islam', 'Medan Estate\r\n', '2013-08-10', 'Aktif', 14, NULL, '2023-12-27 07:46:05'),
('3f1bbbf1-99c9-46a7-9ee2-93cb361f9493', 3138728041, 4561, 'Rahmad Darmawan Lubis', 'L', 'islam', 'Medan Estate', '2013-11-26', 'Aktif', 12, NULL, '2023-12-27 07:46:06'),
('51945012-445a-4eca-99b0-1f20a80ac3fc', 3138748026, 4823, 'Nurin Eiliyah Parinduri\r\n', 'P', 'islam', 'Tanjung Morawa\r\n', '2013-12-01', 'Aktif', 7, NULL, '2023-12-27 07:46:06'),
('98279303-9709-44c7-b479-740e001b327d', 3138821566, 4672, 'Muamar Zain', 'L', 'islam', 'Tangerang', '2013-12-18', 'Aktif', 10, NULL, '2023-12-27 07:46:06'),
('8ccc45df-d744-4138-a658-d27155dfa4ba', 3138980141, 4633, 'Aqila Salsabila\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2013-09-20', 'Aktif', 7, NULL, '2023-12-27 07:46:07'),
('04f6e56d-f84d-4d2b-869e-3d8f8679d22e', 3139205645, 4674, 'Muhammad Alfarizi', 'L', 'islam', 'Medan', '2013-04-03', 'Aktif', 10, NULL, '2023-12-27 07:46:07'),
('d454f6c4-da0a-4832-a05c-3a6e4a08e7c8', 3139295314, 4512, 'Bulan Ramadhany Arfan Lubis\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2013-07-11', 'Aktif', 13, NULL, '2023-12-27 07:46:07'),
('2aad77f8-ab47-4024-af6a-6f28a40c2fdc', 3139391320, 4554, 'Padli Fadilah', 'L', 'islam', 'Laut Dendang', '2013-05-08', 'Aktif', 12, NULL, '2023-12-27 07:46:07'),
('75ecf623-55c5-4c28-bd06-29e79c8f56a8', 3139485730, 5004, 'Azmi Aulifa\r\n', 'L', 'islam', 'Perbaungan\r\n', '2013-04-21', 'Aktif', 14, NULL, '2023-12-27 07:46:08'),
('164a20e1-4f9d-4df0-a06f-cac1781b4c12', 3139703462, 4547, 'Najla Dwi Bintang', 'P', 'islam', 'Laut Dendang', '2013-03-20', 'Aktif', 12, NULL, '2023-12-27 07:46:08'),
('58e87bd2-d3cc-4511-944f-885a54698740', 3139709493, 4550, 'Nur Shina Kayla\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2013-03-23', 'Aktif', 13, NULL, '2023-12-27 07:46:08'),
('c2686023-b7c4-4a06-8f8e-892a55543804', 3139841208, 4648, 'Fachry Luthfy', 'L', 'islam', 'Deli Serdang', '2013-12-11', 'Aktif', 10, NULL, '2023-12-27 07:46:08'),
('15201c2b-cd41-4a2c-81ae-102cd05e34e9', 3140288638, 4838, 'Wila Datul Hasanah Hasibuan\r\n', 'P', 'islam', 'Medan\r\n', '2014-12-27', 'Aktif', 8, NULL, '2023-12-27 07:46:09'),
('be67df20-f3fa-41f6-842e-e47ff22f9dc8', 3140303763, 4808, 'Muhammad Azrul Ramadhan\r\n', 'L', 'islam', 'Medan\r\n', '2014-06-20', 'Aktif', 7, NULL, '2023-12-27 07:46:09'),
('fe6bb619-c881-40d8-8b41-144fc9ffd92b', 3140403159, 4802, 'M. Dimas Darma Wangsa\r\n', 'L', 'islam', 'Medan\r\n', '2014-09-10', 'Aktif', 8, NULL, '2023-12-27 07:46:09'),
('a8b195cb-b7c8-45e1-9ce7-8657d36ea3b9', 3140479053, 4836, 'Tirta Ardiansyah\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2014-11-27', 'Aktif', 8, NULL, '2023-12-27 07:46:10'),
('a67ce466-9ce3-49e6-b823-66e918d630e2', 3140626689, 4818, 'Nazla Qanita Siregar\r\n', 'P', 'islam', 'Medan\r\n', '2014-11-29', 'Aktif', 8, NULL, '2023-12-27 07:46:10'),
('80ed5a40-97a6-41eb-b21a-844effb4c726', 3140756387, 5030, 'Aisyah Marsha\r\n', 'P', 'islam', 'Medan\r\n', '2014-02-03', 'Aktif', 7, NULL, '2023-12-27 07:46:10'),
('2cb6e933-d38f-475f-9655-4055ccef7547', 3140867394, 4840, 'Zikrie Azhar Raihan\r\n', 'L', 'islam', 'Medan\r\n', '2014-10-28', 'Aktif', 7, NULL, '2023-12-27 07:46:10'),
('56fc50ce-88ee-4925-9dc4-09823b0432e2', 3140898934, 4683, 'Nafira Saqilah', 'P', 'islam', 'Laut Dendang', '2014-03-15', 'Aktif', 10, NULL, '2023-12-27 07:46:11'),
('7f215bd0-3ece-4264-a0ef-17a6c1273be1', 3141035046, 4646, 'Eggy Maulana\r\n', 'L', 'islam', 'Diski\r\n', '2014-02-25', 'Aktif', 9, NULL, '2023-12-27 07:46:11'),
('2465fac2-48be-4140-94b0-94208e96c0eb', 3141337940, 4827, 'Rafa Fauzan Ghani\r\n', 'L', 'islam', 'Medan\r\n', '2014-01-19', 'Aktif', 8, NULL, '2023-12-27 07:46:11'),
('41401e22-6026-4f82-8d88-41d253100a6c', 3141504477, 4775, 'Azka Adhyasta Santoso\r\n', 'L', 'islam', 'Medan\r\n', '2014-12-29', 'Aktif', 7, NULL, '2023-12-27 07:46:12'),
('87d23787-ce1e-436b-ad65-1494a15c9f2b', 3141626572, 4639, 'Bilqis Kanza Talita', 'P', 'islam', 'Laut Dendang', '2014-05-05', 'Aktif', 10, NULL, '2023-12-27 07:46:12'),
('422f43e7-2605-442d-bfe7-304be1fb589b', 3141648512, 4820, 'Nicko Ardinata\r\n', 'L', 'islam', 'Tembung\r\n', '2014-08-22', 'Aktif', 8, NULL, '2023-12-27 07:46:12'),
('3fee26d3-10ba-4ff4-bd8d-9751e5649180', 3141786410, 4667, 'Mhd Alwi Ramadan Lubis\r\n', 'L', 'islam', 'Medan\r\n', '2014-06-04', 'Aktif', 9, NULL, '2023-12-27 07:46:12'),
('7b6586aa-2d3f-469b-b338-aea2639a7fa9', 3141929894, 4631, 'Annafiz Sahqir Murtado', 'L', 'islam', 'Laut Dendang', '2014-02-19', 'Aktif', 6, NULL, '2023-12-27 07:46:13'),
('35f91acf-64c4-43e6-8b27-bda12fec7bf4', 3141977021, 4634, 'Atika Azra Naidina\r\n', 'P', 'islam', 'Medan\r\n', '2014-04-01', 'Aktif', 11, NULL, '2023-12-27 07:46:13'),
('261621ac-b4a2-4f74-a5e0-a177d5cbc2e6', 3142021462, 4682, 'Nadira Andara Lintang Nasution\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2014-08-26', 'Aktif', 9, NULL, '2023-12-27 07:46:13'),
('6b63f0e6-c09b-4d05-a7a1-7164eabee64f', 3142205925, 4911, 'Dwi Bulan Handayani', 'P', 'islam', 'Medan\r\n', '2014-11-17', 'Aktif', 4, NULL, '2023-12-27 07:46:13'),
('daa8ebac-d1f4-4549-a7f4-3fe5c30d6187', 3142357061, 4652, 'Fernando Natalyo', 'L', 'islam', 'Medan', '2014-05-21', 'Aktif', 6, NULL, '2023-12-27 07:46:14'),
('07e03a0d-7fe7-456c-9beb-4c61484d3d0b', 3142519987, 4848, 'Muhammad El-Buhari', 'L', 'islam', 'Medan', '2014-11-02', 'Aktif', 6, NULL, '2023-12-27 07:46:14'),
('6be75f2e-cc73-4b0c-81af-3a67cab64bf7', 3142764556, 4638, 'Balqis Zivana Putri', 'P', 'islam', 'Medan', '2014-04-13', 'Aktif', 10, NULL, '2023-12-27 07:46:14'),
('2bf55dd4-3458-4adb-a0da-be87bde55a99', 3142768663, 4684, 'Nafisah Muharrami Zain\r\n', 'P', 'islam', 'Medan', '2014-10-31', 'Aktif', 9, NULL, '2023-12-27 07:46:15'),
('af48378c-5588-4894-b895-50bcaf2a4dd9', 3143024915, 5032, 'DESWA SALSABILA\r\n', 'P', 'islam', 'MEDAN\r\n', '2014-09-21', 'Aktif', 7, NULL, '2023-12-27 07:46:15'),
('9d1e63ed-db2a-4348-abb8-0212fedec169', 3143044044, 4675, 'Muhammad Fauzi Al Sandi', 'L', 'islam', 'Medan Estate', '2014-02-28', 'Aktif', 10, NULL, '2023-12-27 07:46:15'),
('51a45dd2-cc5f-450a-9656-77046deb8ed1', 3143109089, 5037, 'Zira Antanovia\r\n', 'P', 'islam', 'Simalungun\r\n', '2014-11-12', 'Aktif', 8, NULL, '2023-12-27 07:46:15'),
('4fedb291-dd24-43de-9e2c-c17a0284b9ae', 3143148307, 4824, 'Nurul Amelia MT\r\n', 'P', 'islam', 'Medan\r\n', '2014-10-15', 'Aktif', 7, NULL, '2023-12-27 07:46:16'),
('ea183ae3-94dd-420f-b610-fdc00ab081b4', 3143189824, 4665, 'M. Rizky Maulana\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2014-06-08', 'Aktif', 7, NULL, '2023-12-27 07:46:16'),
('a0b10d8a-959e-42dd-8f06-81c0f9e85353', 3143703485, 4664, 'M. Rizki Affandi', 'L', 'islam', 'Bandar Khalipah', '2014-04-03', 'Aktif', 10, NULL, '2023-12-27 07:46:16'),
('ed2a94dd-7e0f-4097-8e32-bbc5f1d76acd', 3143823968, 4671, 'Miyana Puspita\r\n', 'P', '', 'Sampali\r\n', '2014-03-15', 'Aktif', 9, NULL, '2023-12-27 07:46:16'),
('d2fbd6c4-03c1-4852-9083-19c74604e11f', 3143927473, 4710, 'Salsabila Azzahra\r\n', 'P', 'islam', 'Medan\r\n', '2014-07-27', 'Aktif', 11, NULL, '2023-12-27 07:46:17'),
('2b19e428-a72a-44b3-8385-995b15935ede', 3143979209, 4830, 'Rezky Prasetyo\r\n', 'L', 'islam', 'Medan\r\n', '2014-09-09', 'Aktif', 8, NULL, '2023-12-27 07:46:17'),
('8f7aca67-9f7d-47cb-8aa5-042f1b28481a', 3144361665, 4701, 'Rafa Al Zikri\r\n', 'L', 'islam', 'Medan\r\n', '2014-07-19', 'Aktif', 11, NULL, '2023-12-27 07:46:17'),
('66fd95a6-5463-4dd1-bdc4-11286bc2be0e', 3144536776, 4977, 'Yoga Kurniawan Dalimunthe', 'L', 'islam', 'Medan', '2014-04-11', 'Aktif', 4, NULL, '2023-12-27 07:46:18'),
('8230da2a-7329-4e88-860c-db1b5d1847ac', 3144616373, 4799, 'Khafi El Hamam Parinduri\r\n', 'L', 'islam', 'Medan\r\n', '2014-12-04', 'Aktif', 8, NULL, '2023-12-27 07:46:18'),
('e51cf699-18ab-4761-a739-f146ca20f114', 3144970498, 4839, 'Yadi\r\n', 'L', 'islam', 'Medan Estate\r\n', '2014-12-03', 'Aktif', 8, NULL, '2023-12-27 07:46:18'),
('a203b053-c104-48c7-8919-bb60d31989ca', 3145127315, 4835, 'Surya Gemilang', 'L', 'islam', 'Laut Dendang', '2014-11-15', 'Aktif', 5, NULL, '2023-12-27 07:46:18'),
('3ed25902-3a33-492c-8346-57fe8314ff4b', 3145515773, 4761, 'Aidil Akbar', 'L', 'islam', 'Laut Dendang', '2014-10-04', 'Aktif', 5, NULL, '2023-12-27 07:46:19'),
('0800b660-6a32-4c89-b815-562afe92b346', 3145678900, 4650, 'Fakhira Salwa Ramadani\r\n', 'P', 'islam', 'Medan\r\n', '2014-07-02', 'Aktif', 11, NULL, '2023-12-27 07:46:19'),
('bd1acb0f-df26-4ce3-81e8-79cdaeb4cbe3', 3145981910, 4677, 'Muhammad Manaf Nasution', 'L', 'islam', 'Medan', '2013-12-27', 'Aktif', 10, NULL, '2023-12-27 07:46:19'),
('36c1281f-cc6f-446f-a4f1-167b3ea4995f', 3146021657, 4704, 'Reno Al-Farizi\r\n', 'L', 'islam', 'Medan\r\n', '2014-09-10', 'Aktif', 11, NULL, '2023-12-27 07:46:20'),
('d3efeb15-43e7-44ac-bd50-64b5488c94c4', 3146311718, 4654, 'Gibran Fabio Aska', 'L', 'islam', 'Medan', '2013-10-19', 'Aktif', 10, NULL, '2023-12-27 07:46:20'),
('5c80edb9-057c-4a94-8326-29a5953bbb7c', 3146851083, 4626, 'Al Fathir Abiyu\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2014-02-19', 'Aktif', 7, NULL, '2023-12-27 07:46:20'),
('7c7c0884-353e-406d-9277-0b0a75c662f1', 3147089616, 4807, 'Mimifa Khairunnisa\r\n', 'P', 'islam', 'Bandar Khalipah\r\n', '2014-08-17', 'Aktif', 7, NULL, '2023-12-27 07:46:20'),
('c9cb47dc-779a-49c0-a518-b057ba69420f', 3147158592, 4629, 'Andini Putri Pratama\r\n', 'P', 'islam', 'Medan\r\n', '2014-06-03', 'Aktif', 11, NULL, '2023-12-27 07:46:21'),
('f218bf1b-5d9c-4209-9eb5-c779e559df38', 3147300170, 4837, 'Ufaira Nur Afifa\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2014-04-10', 'Aktif', 7, NULL, '2023-12-27 07:46:21'),
('2be771fc-934c-43ca-b8d4-c00b5daf8eee', 3147589325, 4770, 'Arjuna Arya Al-Qohar\r\n', 'L', 'islam', 'Dumai\r\n', '2014-02-08', 'Aktif', 8, NULL, '2023-12-27 07:46:21'),
('377661b6-1a81-4e7d-9b40-3c9243de7962', 3147851930, 4689, 'Nayra Sahbillah Azharah\r\n', 'P', 'islam', 'Bandar Setia\r\n', '2014-08-12', 'Aktif', 9, NULL, '2023-12-27 07:46:21'),
('6a93c619-463d-464e-a4cf-86851454251e', 3148231089, 4841, 'Alika Naila Putri\r\n', 'P', 'islam', 'Bandar Khalipah\r\n', '2014-06-23', 'Aktif', 8, NULL, '2023-12-27 07:46:22'),
('cd0dfcc2-4248-4b92-befd-513d0d7f4bba', 3148301517, 4660, 'Khairil Fahri\r\n', 'L', 'islam', 'Medan\r\n', '2014-01-02', 'Aktif', 11, NULL, '2023-12-27 07:46:22'),
('01cd8d0b-358e-4cef-8be7-4346a56905fa', 3148332130, 4691, 'Nazihah Muharrami Zain\r\n', 'P', 'islam', 'Medan\r\n', '2014-10-31', 'Aktif', 9, NULL, '2023-12-27 07:46:22'),
('ba85ec73-c133-4ad3-80c4-7d82a68d14fb', 3148592006, 4813, 'Mutiya Zafira\r\n', 'P', 'islam', 'Medan\r\n', '2014-11-09', 'Aktif', 7, NULL, '2023-12-27 07:46:23'),
('34cdadbc-a21c-4cf0-a922-48e4ecaaf0ea', 3148594164, 4636, 'Azizah Puspitasari\r\n', 'P', 'islam', 'Medan\r\n', '2014-04-06', 'Aktif', 11, NULL, '2023-12-27 07:46:23'),
('f2ce38ae-e483-4919-ae3e-ea5a578ac356', 3148788815, 4764, 'Alfa Aditya\r\n', 'L', 'islam', 'Medan\r\n', '2014-05-01', 'Aktif', 7, NULL, '2023-12-27 07:46:23'),
('5a8accdf-4dc1-4f6b-b276-5ac65d60100a', 3148795966, 4760, 'Agung Prawira\r\n', 'L', 'islam', 'Medan\r\n', '2014-11-16', 'Aktif', 7, NULL, '2023-12-27 07:46:24'),
('079328c8-afa7-499f-99f2-f85e0b55e6c7', 3148797859, 4834, 'Siti Humairah\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2014-12-20', 'Aktif', 8, NULL, '2023-12-27 07:46:24'),
('257c9c99-ddb1-4c4f-abe8-f370ab397dfe', 3148975146, 4658, 'Hasby Rahman Lubis', 'L', 'islam', 'Medan', '2014-07-10', 'Aktif', 10, NULL, '2023-12-27 07:46:24'),
('1689b3a8-2253-40e9-91eb-19706f7653d0', 3149096407, 4644, 'Duwi Julianti', 'P', 'islam', 'Dumai', '2014-06-04', 'Aktif', 10, NULL, '2023-12-27 07:46:24'),
('124038ff-711f-47b6-bac9-17a02bb20986', 3149648071, 4627, 'Al Nadhif Putra Sundana\r\n', 'L', 'islam', 'Medan\r\n', '2014-06-14', 'Aktif', 9, NULL, '2023-12-27 07:46:25'),
('7190af4e-b67e-4bba-bd0f-9951c262025f', 3149654138, 4663, 'M. Alcantara Zaffran\r\n', 'L', 'islam', 'Medan\r\n', '2014-05-09', 'Aktif', 11, NULL, '2023-12-27 07:46:25'),
('f65f87f0-75b7-441f-8f4d-911a5e860869', 3149726016, 5035, 'Putri Thalita Ulfa\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2014-03-08', 'Aktif', 8, NULL, '2023-12-27 07:46:25'),
('e64cbd8c-58d4-4be3-aad0-bd90e3779a48', 3150068038, 4932, 'M. Aziz Maulana', 'L', 'islam', 'Medan Estate', '2015-12-12', 'Aktif', 5, NULL, '2023-12-27 07:46:26'),
('44544658-3ca7-4c78-ba92-a6be18bfaa5a', 3150108687, 4901, 'Chila Mikayla', 'P', 'islam', 'Laut Dendang', '2015-12-28', 'Aktif', 5, NULL, '2023-12-27 07:46:26'),
('5f70ea9b-596e-4f2a-9396-a7d69362e148', 3150260443, 4826, 'Raditya Pratama\r\n', 'L', 'islam', 'Medan\r\n', '2015-03-21', 'Aktif', 7, NULL, '2023-12-27 07:46:26'),
('406ac426-d690-4949-9fcd-e4742d83409e', 3150283414, 4904, 'Daffa Pranaja', 'L', 'islam', 'Medan', '2015-10-09', 'Aktif', 4, NULL, '2023-12-27 07:46:26'),
('ede175b3-9326-42be-82dc-3dbe29dcc6f2', 3150517546, 4871, 'Adelia Putri', 'P', 'islam', 'Medan', '2015-10-06', 'Aktif', 5, NULL, '2023-12-27 07:46:27'),
('a825de7a-c1c4-4ad7-b0ee-fac2876d302d', 3150519547, 4880, 'Al Rizky Falistira', 'L', 'islam', 'Laut Dendang', '2015-09-17', 'Aktif', 6, NULL, '2023-12-27 07:46:27'),
('e73cebb8-1a28-445b-a21c-e7148fd98200', 3150664836, 4964, 'Raisya Rahma', 'P', 'islam', 'B. Khalipah', '2015-08-05', 'Aktif', 4, NULL, '2023-12-27 07:46:27'),
('d63ab47b-2b0d-44b8-b75d-e302c6e61327', 3150949421, 4846, 'Nadia Azzahra\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2015-01-13', 'Aktif', 8, NULL, '2023-12-27 07:46:27'),
('989973ba-95d6-4432-9532-7dbd46d0d8d2', 3151265721, 4800, 'Khaira Syahfitri\r\n', 'P', 'islam', 'Sampali\r\n', '2015-07-26', 'Aktif', 8, NULL, '2023-12-27 07:46:28'),
('bd8d60c1-72c7-4364-81df-0131d3683916', 3151405271, 4961, 'Raffi Dary Abiyyu', 'L', 'islam', 'Medan', '2015-09-12', 'Aktif', 4, NULL, '2023-12-27 07:46:28'),
('3f07cbe6-f444-4a29-bc80-137f756bc096', 3151463658, 4768, 'Annaura Yasmine\r\n', 'P', 'islam', 'Bandar Selamat\r\n', '2015-04-12', 'Aktif', 7, NULL, '2023-12-27 07:46:28'),
('b02d2b5a-81d6-454e-8e69-b060cf6b0ef6', 3151600636, 4792, 'Febrian Syahputra\r\n', 'L', 'islam', 'Tembung\r\n', '2015-02-21', 'Aktif', 8, NULL, '2023-12-27 07:46:29'),
('9333af14-3e1a-4a9d-ab93-5ac0ae2b3e94', 3151653011, 5034, 'MUHAMMAD RAYHAN REFIKANZAH\r\n', 'L', 'islam', 'Bandar Setia\r\n', '2015-01-05', 'Aktif', 8, NULL, '2023-12-27 07:46:29'),
('b96e4649-1427-49c0-b0de-811a8fa9f380', 3151750034, 4844, 'Ihsan Akmal', 'L', 'islam', 'Medan', '2015-05-31', 'Aktif', 5, NULL, '2023-12-27 07:46:29'),
('667e2584-1c4e-4efb-a2a6-540226e71243', 3151773197, 4908, 'Desy Rahma Sari', 'P', 'islam', 'Laut Dendang', '2015-12-16', 'Aktif', 6, NULL, '2023-12-27 07:46:30'),
('c5460b44-dff0-488c-a1bd-b105bf1855dc', 3151860080, 4947, 'Muhammad Satria', 'L', 'islam', 'Medan', '2015-02-28', 'Aktif', 4, NULL, '2023-12-27 07:46:30'),
('403de046-4769-4a69-9f67-a5ccb184c4a9', 3151898759, 4902, 'Cleopatra Rensy', 'L', 'islam', 'Medan', '2015-12-28', 'Aktif', 6, NULL, '2023-12-27 07:46:30'),
('69d76307-fdcd-43a9-9865-716ace8e5f34', 3152015709, 4907, 'Denis Pratama', 'L', 'islam', 'Laut Dendang', '2015-07-10', 'Aktif', 5, NULL, '2023-12-27 07:46:30'),
('e948c43e-a685-4488-93cd-20d7749d2455', 3152049803, 4903, 'Dafa', 'L', 'islam', 'Laut Dendang', '2015-10-27', 'Aktif', 4, NULL, '2023-12-27 07:46:31'),
('a0a3a635-3990-4c6b-abdc-5435aff7cb34', 3152136053, 4791, 'Febiyana', 'P', 'islam', 'Medan', '2015-02-06', 'Aktif', 4, NULL, '2023-12-27 07:46:31'),
('472bcfaa-9c42-4b12-b7e1-3bbc7efcdafc', 3152285539, 4795, 'Hafiza Al-Malika\r\n', 'P', 'islam', 'Bandar Setia\r\n', '2015-02-13', 'Aktif', 8, NULL, '2023-12-27 07:46:31'),
('e58a7aa9-3324-4907-9b17-6170b8e9c570', 3152516173, 4883, 'Alfi Andra Aditya', 'L', 'islam', 'Medan', '2015-10-04', 'Aktif', 5, NULL, '2023-12-27 07:46:32'),
('20d7138d-2a01-40c9-89d8-6b6a8aeda8ea', 3152534706, 4825, 'Nurul Putri Kharimah\r\n', 'P', 'islam', 'Medan Estatet\r\n', '2015-07-10', 'Aktif', 8, NULL, '2023-12-27 07:46:32'),
('e6d0c7e6-9a45-4fbf-9f31-659f6334a6ad', 3152614399, 4785, 'Doli Al-Hafiz Zaky\r\n', 'L', 'islam', 'Medan Estate\r\n', '2015-03-12', 'Aktif', 8, NULL, '2023-12-27 07:46:32'),
('55302d5f-689b-4a46-92e1-66dc0925b268', 3152691268, 4975, 'Vino Raditya', 'L', 'islam', 'Binjai\r\n', '2015-07-03', 'Aktif', 4, NULL, '2023-12-27 07:46:32'),
('5805e55e-ffbf-4cac-875f-caf0f3b99159', 3152751369, 4969, 'Salsabila', 'P', 'islam', 'Medan', '2015-08-26', 'Aktif', 5, NULL, '2023-12-27 07:46:33'),
('c1c35396-6b81-4b4a-a901-a8326596a8ab', 3153039218, 4984, 'Imam Ali', 'L', 'islam', 'Medan', '2015-02-20', 'Aktif', 5, NULL, '2023-12-27 07:46:33'),
('1d28c8ef-0b37-4fbe-996a-210fdddd9acd', 3153103412, 4801, 'M. Alfazan\r\n', 'L', 'islam', 'Medan Estate\r\n', '2015-10-23', 'Aktif', 8, NULL, '2023-12-27 07:46:33'),
('487ef1b3-cb03-4ced-8c57-aabf835d8688', 3153176485, 4921, 'Hafizah Khayyirah Lubna\r\n', 'P', 'islam', 'Depok\r\n', '2015-05-13', 'Aktif', 8, NULL, '2023-12-27 07:46:34'),
('731a61b2-87bc-436e-acf1-10f8d7c780b2', 3153311551, 4874, 'Aisyah Koriah', 'P', 'islam', 'Medan', '2015-02-21', 'Aktif', 6, NULL, '2023-12-27 07:46:34'),
('7a3a26cf-b216-4268-8270-fcacac27f84f', 3153346241, 4772, 'Arka Syafatir Al-Hakim\r\n', 'L', 'islam', 'Medan\r\n', '2015-06-17', 'Aktif', 7, NULL, '2023-12-27 07:46:34'),
('12564760-00f6-452b-a16b-a43ed3b2df2f', 3153501218, 4976, 'Virza Andara', 'L', 'islam', 'Laut Dendang', '2015-12-24', 'Aktif', 5, NULL, '2023-12-27 07:46:34'),
('6470c4af-9800-418f-b12d-7083f78d9c96', 3153796358, 4829, 'Rania Putri\r\n', 'P', 'islam', 'Medan\r\n', '2015-04-28', 'Aktif', 8, NULL, '2023-12-27 07:46:35'),
('791457ed-a1cc-4631-947d-3798a6deda23', 3153950133, 4788, 'Eza Irawan Syahputra\r\n', 'L', 'islam', 'Medan Estate\r\n', '2015-08-26', 'Aktif', 7, NULL, '2023-12-27 07:46:35'),
('96c49e11-7223-4577-9ee2-14943fa0b9ec', 3154141448, 4798, 'Keyla Saputri\r\n', 'L', 'islam', 'Bandar Setia\r\n', '2015-01-18', 'Aktif', 7, NULL, '2023-12-27 07:46:35'),
('1c557976-0b3a-4511-9b20-b785c6756a26', 3154303778, 4954, 'Nazwa Khairani Putri', 'P', 'islam', 'Medan', '2015-12-25', 'Aktif', 4, NULL, '2023-12-27 07:46:35'),
('ad556065-7a44-4680-8381-6e3e28b60f0f', 3154599737, 4762, 'Akila Sahira Nasution\r\n', 'P', 'islam', 'Bandar Khalipah\r\n', '2015-03-10', 'Aktif', 7, NULL, '2023-12-27 07:46:36'),
('94281010-cb45-4860-8d39-2a853016a20e', 3154936826, 4822, 'Nuria Rahmah\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2015-01-22', 'Aktif', 8, NULL, '2023-12-27 07:46:36'),
('9294754b-f387-4309-a799-d200c3f46119', 3155218654, 4941, 'Muhammad Fariz Akbar', 'L', 'islam', 'Bandar Setia', '2015-08-25', 'Aktif', 5, NULL, '2023-12-27 07:46:36'),
('56ebc906-18e3-423c-87e7-da8a9b19f701', 3155462364, 4819, 'Nazwa Rahmadina Prasetio\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2015-07-04', 'Aktif', 7, NULL, '2023-12-27 07:46:37'),
('edd80314-55c4-453a-a570-a038e556a241', 3155746449, 4816, 'Naura Balqis Suwanika\r\n', 'P', 'islam', 'Medan\r\n', '2015-09-15', 'Aktif', 8, NULL, '2023-12-27 07:46:37'),
('e861080d-f9ba-4cc8-86e5-fa33c3ddaf59', 3155810073, 4797, 'Juan Rodis Silalahi\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2015-04-02', 'Aktif', 7, NULL, '2023-12-27 07:46:37'),
('9f85ebe7-b8ec-4aba-b0d2-3b7f28de1192', 3155880886, 5036, 'SYAUQI RAMADHAN JUANDA\r\n', 'L', 'islam', 'KLUMPANG KAMPUNG\r\n', '2015-07-14', 'Aktif', 8, NULL, '2023-12-27 07:46:37'),
('1942120c-614d-4787-ac41-5709257f0099', 3156386590, 4893, 'Asyifa Yuwandira', 'P', 'islam', 'Medan', '2015-08-14', 'Aktif', 6, NULL, '2023-12-27 07:46:38'),
('42b83863-ed0f-46b1-ab03-25f0344e8290', 3156403436, 4905, 'Dedek Aldiansyah', 'L', 'islam', 'Pelawan', '2015-10-14', 'Aktif', 6, NULL, '2023-12-27 07:46:38'),
('7c164abd-a7ca-468d-aa74-e9cea9e2a688', 3156439610, 4963, 'Raisa Syahputri Siregar', 'P', 'islam', 'Medan', '2015-01-02', 'Aktif', 4, NULL, '2023-12-27 07:46:38'),
('aec51d4f-8945-4dd0-98bf-d43468c33cbe', 3156468955, 4968, 'Rizky Dwi Anggara', 'L', 'islam', 'Medan', '2015-11-24', 'Aktif', 5, NULL, '2023-12-27 07:46:39'),
('f304899b-4419-4918-a5e6-5d026d44709a', 3156559077, 4886, 'Andini Safitri', 'P', 'islam', 'Medan', '2015-07-28', 'Aktif', 5, NULL, '2023-12-27 07:46:39'),
('12a5d0a7-640f-4992-8b9a-272d592576d4', 3156726778, 4909, 'Dinda Kirana', 'P', 'islam', 'Medan', '2015-07-08', 'Aktif', 6, NULL, '2023-12-27 07:46:39'),
('97d1aacd-7653-4b7f-8376-2b3e1acfa9cd', 3156811377, 4809, 'Muhammad Dzaki Al Mair\r\n', 'L', 'islam', 'Medan\r\n', '2015-02-20', 'Aktif', 7, NULL, '2023-12-27 07:46:39'),
('2d698a5c-c9f4-43fa-a322-8bc9a5fc0367', 3157255269, 4946, 'Muhammad Rama', 'L', 'islam', 'Laut Dendang', '2015-03-01', 'Aktif', 4, NULL, '2023-12-27 07:46:40'),
('a8f2698e-6233-426f-be0f-20e383708c08', 3157264546, 4786, 'Dwi Meilany\r\n', 'P', 'islam', 'Aceh Barat\r\n', '2015-05-07', 'Aktif', 8, NULL, '2023-12-27 07:46:40'),
('085202d7-95aa-495a-95a3-4cca90fa6d54', 3157285352, 4793, 'Gista Khairani\r\n', 'P', 'islam', 'Laut Dendang\r\n', '2015-07-05', 'Aktif', 7, NULL, '2023-12-27 07:46:40'),
('79f125af-1752-4f9a-9e18-dd2ba3e533ef', 3157583099, 4912, 'Enjeli Purnama', 'P', 'islam', 'Medan', '2015-05-23', 'Aktif', 4, NULL, '2023-12-27 07:46:40'),
('a33b3378-3266-4afe-9d91-12fc5e84cc26', 3157754103, 4779, 'Beby Pertiwi\r\n', 'P', 'islam', 'Medan\r\n', '2015-09-16', 'Aktif', 7, NULL, '2023-12-27 07:46:41'),
('6b157ee4-d3e6-4089-9a40-7bf46ee57b48', 3157795443, 4766, 'Andhika Iskandar Manik\r\n', 'L', 'islam', 'Medan\r\n', '2015-05-07', 'Aktif', 8, NULL, '2023-12-27 07:46:41'),
('76ed67a1-bcd0-431a-880a-5e4599539d2b', 3157951624, 4794, 'Haafidzah Aznii Yuwandiera\r\n', 'P', 'islam', 'Medan Estate\r\n', '2015-02-04', 'Aktif', 8, NULL, '2023-12-27 07:46:41'),
('4f37db7c-07c4-46ef-ad4c-58b37665b2b8', 3158036666, 4882, 'Alfazar', 'L', 'islam', 'Medan Estate', '2015-10-06', 'Aktif', 6, NULL, '2023-12-27 07:46:42'),
('31a1f7cc-f506-4f87-96ab-6e06023b62e2', 3158192512, 4806, 'Mikayla Aziya Putri\r\n', 'P', 'islam', 'Sei Buluh\r\n', '2015-08-23', 'Aktif', 7, NULL, '2023-12-27 07:46:42'),
('3016d1a3-b009-4ce1-9215-d9e23d6ec22e', 3158294054, 4769, 'Aqila Balqis Zahara\r\n', 'P', 'islam', 'Medan\r\n', '2015-01-09', 'Aktif', 8, NULL, '2023-12-27 07:46:42'),
('ea24d53f-89d5-498c-b059-7ab57505a487', 3158967793, 4776, 'Azka Azfar Rabbani\r\n', 'L', 'islam', 'Medan\r\n', '2015-10-03', 'Aktif', 7, NULL, '2023-12-27 07:46:42'),
('85b69d4b-175e-4e9b-80e6-5f68bec03919', 3159493429, 4774, 'Aulia Ramadani\r\n', 'P', 'islam', 'Medan\r\n', '2015-06-18', 'Aktif', 7, NULL, '2023-12-27 07:46:43'),
('171630d4-e0ab-4246-8bde-b7a784bd53f4', 3159522129, 4804, 'M. Raffa Alfiansyah\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2015-03-08', 'Aktif', 7, NULL, '2023-12-27 07:46:43'),
('2247242a-7f18-40c7-bf9e-c0e61a5b2286', 3159635258, 4933, 'M. Malikal Mulki', 'L', 'islam', 'Medan', '2015-10-31', 'Aktif', 5, NULL, '2023-12-27 07:46:43'),
('a987e1df-73ca-4906-9592-4615611c8859', 3159736593, 4821, 'Noval Febryansyah\r\n', 'L', 'islam', 'Laut Dendang\r\n', '2015-02-01', 'Aktif', 7, NULL, '2023-12-27 07:46:43'),
('7c5b01db-8d3d-402f-828c-6309d045fbe7', 3159754378, 4920, 'Hafiz Hardiansyah', 'L', 'islam', 'Medan', '2015-10-21', 'Aktif', 5, NULL, '2023-12-27 07:46:44'),
('7a5b6a94-1ebc-4cdc-8e80-c2c1071a5589', 3159913172, 4867, 'Abdurrahim', 'L', 'islam', 'Medan', '2015-12-16', 'Aktif', 6, NULL, '2023-12-27 07:46:44'),
('ce4297cf-ef36-4019-abd5-378efb498645', 3160173958, 4965, 'Reyfa Nadia Putri', 'P', 'islam', 'Medan', '2016-12-05', 'Aktif', 5, NULL, '2023-12-27 07:46:44'),
('ed2f7731-8d14-4ef9-9cc3-86ee7717aa32', 3160279528, 4928, 'Jihan Amelia', 'P', 'islam', 'Laut Dendang', '2016-05-03', 'Aktif', 5, NULL, '2023-12-27 07:46:45'),
('8f6fdadd-d860-4588-80c7-92b8b431a7c8', 3160319072, 4887, 'Anindya Alesha Gunawan', 'P', 'islam', 'Pematang Johor', '2016-01-05', 'Aktif', 4, NULL, '2023-12-27 07:46:45'),
('3f640fea-70ca-4e13-9ee2-b94590975b85', 3160867576, 4948, 'Mutiara', 'P', 'islam', 'Medan', '2016-02-15', 'Aktif', 4, NULL, '2023-12-27 07:46:45'),
('0a4d1e0d-187c-4ca7-bb0b-e4436f0b3ebc', 3160927987, 4960, 'Rafani Putri Salsabila', 'P', 'islam', 'Medan', '2016-08-11', 'Aktif', 5, NULL, '2023-12-27 07:46:45'),
('8ca1cc91-66f4-4578-b82f-c0b215815f17', 3161344902, 4866, 'Abdil Rasya', 'L', 'islam', 'Sampali', '2016-04-08', 'Aktif', 4, NULL, '2023-12-27 07:46:46'),
('bc0eba1a-1771-4382-b9e7-74ed27ae8931', 3162118714, 4962, 'Rafi Adithya Al Khadapi', 'L', 'islam', 'Medan', '2016-02-17', 'Aktif', 4, NULL, '2023-12-27 07:46:46');
INSERT INTO `tbl_siswas` (`user_id`, `nisn`, `nipd`, `nama_siswa`, `jk_siswa`, `agama_siswa`, `tempat_lahir`, `tanggal_lahir`, `status_siswa`, `id_kelas`, `created_at`, `updated_at`) VALUES
('1abc8f1a-c9f3-4523-9249-3bc76e758ed1', 3162739615, 4971, 'Sila Pirlia', 'P', 'islam', 'Desa Selamat', '2016-04-21', 'Aktif', 5, NULL, '2023-12-27 07:46:46'),
('22d2e76c-5b45-4642-9b55-8e77a8243911', 3163209567, 4879, 'Al Pandy Ramadhan', 'L', 'islam', 'Laut Dendang', '2016-06-28', 'Aktif', 6, NULL, '2023-12-27 07:46:47'),
('9956f595-cf5a-451f-87ea-774fa5d0aad6', 3163425131, 4892, 'Arsyah Rama Putra', 'L', 'islam', 'Tembung', '2016-01-13', 'Aktif', 6, NULL, '2023-12-27 07:46:47'),
('b1f5766d-29a2-463c-8004-e2711393ecf3', 3163456167, 4923, 'Hildan Soleh Admaja', 'L', 'islam', 'Medan', '2016-01-22', 'Aktif', 5, NULL, '2023-12-27 07:46:47'),
('21072216-4734-4bdc-862c-f6d1ff4ba9bb', 3163561272, 4900, 'Bunga Ranjani', 'L', 'islam', 'Langkat', '2016-06-01', 'Aktif', 6, NULL, '2023-12-27 07:46:47'),
('2dd11ec8-0988-48bb-8cfd-6f8aa492cee2', 3163630437, 4890, 'Aqilla Al Adzra', 'P', 'islam', 'Sei Semayang', '2016-05-05', 'Aktif', 6, NULL, '2023-12-27 07:46:48'),
('626d1fef-aabf-447a-a5dc-6e68ae24178c', 3163904536, 4930, 'Kanasya Ayu Dia', 'P', 'islam', 'Laut Dendang', '2016-09-05', 'Aktif', 5, NULL, '2023-12-27 07:46:48'),
('f46a2a07-82b2-4cbe-b2be-0acc033daf53', 3164216743, 4913, 'Fadhli Kurniawan', 'L', 'islam', 'Medan', '2016-08-25', 'Aktif', 6, NULL, '2023-12-27 07:46:48'),
('0b409434-a2de-4327-8a18-14bb636d4913', 3164874840, 4937, 'Mhd. Rizky Ananda', 'L', 'islam', 'Medan', '2016-03-05', 'Aktif', 4, NULL, '2023-12-27 07:46:48'),
('1a94c3e8-dc82-476e-8655-a1a1ded8b143', 3164892372, 4981, 'Zulfan Azhar Raihan', 'L', 'islam', 'Laut Dendang', '2016-04-06', 'Aktif', 4, NULL, '2023-12-27 07:46:49'),
('1bf42985-5ce1-40c7-a5f1-f23d2bc2a797', 3164972877, 4894, 'Aurel Natasya', 'P', 'islam', 'Medan', '2016-01-06', 'Aktif', 4, NULL, '2023-12-27 07:46:49'),
('5a1ab053-2cbc-42dd-b78b-a8c5d3f0f3d3', 3165037756, 4938, 'Mikayla Rastya', 'P', 'islam', 'Medan', '2016-03-02', 'Aktif', 5, NULL, '2023-12-27 07:46:49'),
('d85e78b8-ff30-4814-bd5a-5daa33438425', 3165365349, 4936, 'Mhd. Isa Prayoga', 'L', 'islam', 'Bandar Khalipah', '2014-08-11', 'Aktif', 5, NULL, '2023-12-27 07:46:50'),
('4176bc02-c11e-43da-a9a9-37ff10e334d0', 3165570621, 4869, 'Abqari Runako', 'L', 'islam', 'Medan', '2016-04-27', 'Aktif', 5, NULL, '2023-12-27 07:46:50'),
('83614dfd-4f20-4098-b35d-218ac3b43bb4', 3165780656, 4974, 'Uswatun Hasana', 'P', 'islam', 'Medan', '2016-03-15', 'Aktif', 4, NULL, '2023-12-27 07:46:50'),
('4424710b-7406-4b44-be8e-77a5cbc88e77', 3165855697, 4888, 'Annisa Sri Jingga', 'P', 'islam', 'Langsa', '2016-01-10', 'Aktif', 4, NULL, '2023-12-27 07:46:50'),
('707aa770-6ccc-4fd9-a493-7a340c13fb6f', 3166017319, 4972, 'Syahilla Az Zaheerah', 'P', 'islam', 'Medan', '2016-06-26', 'Aktif', 4, NULL, '2023-12-27 07:46:51'),
('10858538-c6e9-42f7-a5e1-8e56eff239fc', 3166067636, 4927, 'Januar Revaldi', 'L', 'islam', 'Medan Estate', '2016-01-20', 'Aktif', 4, NULL, '2023-12-27 07:46:51'),
('77ba1d7e-91a8-496d-8d01-c2752ecab6d3', 3166180093, 4967, 'Rifka Ramadani Nasution', 'P', 'islam', 'Medan', '2016-06-17', 'Aktif', 5, NULL, '2023-12-27 07:46:51'),
(NULL, 3166186576, 4939, 'Muhammad Al Fatih', 'L', 'islam', 'Bandar Klippa', '2016-04-06', 'Aktif', 4, NULL, NULL),
('597dfe55-93db-4661-a933-118725b45b52', 3166424584, 4931, 'Keysa Zahra', 'P', 'islam', 'Laut Dendang', '2016-02-19', 'Aktif', 4, NULL, '2023-12-27 07:46:51'),
('430ba09e-fbfb-43b0-80c0-26d5b5193c3b', 3166869418, 4910, 'Diwa Ramdahan', 'L', '', 'Medan', '2016-06-14', 'Aktif', 6, NULL, '2023-12-27 07:46:52'),
('6b097f6a-0619-4840-9323-afcfbc8ca68f', 3167047726, 4940, 'Muhammad Alif Randika', 'L', 'islam', 'Medan', '2016-01-04', 'Aktif', 5, NULL, '2023-12-27 07:46:52'),
(NULL, 3167070238, 4935, 'M. Rizky Syahputra', 'L', 'islam', 'Laut Dendang', '2016-02-03', 'Aktif', 4, NULL, NULL),
('dece579b-1ef0-42bf-9881-22d9e32fe0ab', 3167128995, 4870, 'Abri Syam Rainan Lubis', 'L', 'islam', 'Laut Dendang', '2016-04-15', 'Aktif', 5, NULL, '2023-12-27 07:46:52'),
('9e826739-144e-456a-83c5-7afa64bb7bbd', 3167174657, 4891, 'Arinka Jhui', 'P', 'islam', 'Sambirejo Tanjung', '2016-01-01', 'Aktif', 6, NULL, '2023-12-27 07:46:53'),
('07550566-d6ec-467b-afa0-e00847138a4a', 3167599223, 4878, 'Akila Firzanah Ritonga', 'P', 'islam', 'Pelalawan', '2016-03-01', 'Aktif', 5, NULL, '2023-12-27 07:46:53'),
('1326d576-b488-48ed-9717-a89b0f1b1886', 3167616978, 4945, 'Muhammad Rafa Anggara', 'L', 'islam', 'Medan', '2016-05-30', 'Aktif', 4, NULL, '2023-12-27 07:46:53'),
('fc77cf81-51bc-41c2-a135-1ac54cd7350e', 3167941589, 4889, 'Aqila Syahirah Rafifah', 'P', 'islam', 'Medan', '2016-03-18', 'Aktif', 5, NULL, '2023-12-27 07:46:53'),
('df3d25b1-ea8b-40ca-ae0e-2345f4a27832', 3168646248, 4970, 'Sandrin Almira', 'P', 'islam', 'Medan', '2016-08-16', 'Aktif', 5, NULL, '2023-12-27 07:46:54'),
('c6c8ad7d-3870-442f-9eb8-93e9318e43ee', 3168671924, 4915, 'Fiona Adelia\r\n', 'P', 'islam', 'Medan\r\n', '2016-04-11', 'Aktif', 4, NULL, '2023-12-27 07:46:54'),
('2b50072a-671c-4fc2-b559-91aea461d56a', 3169184904, 4973, 'Syahira Aulia Putri', 'P', 'islam', 'Bandar Setia', '2016-03-30', 'Aktif', 5, NULL, '2023-12-27 07:46:54'),
('1c636cd5-9f12-430f-a058-67f12e754dbb', 3169812626, 4897, 'Azril Athafariz Damanik', 'L', 'islam', 'Laut Dendang', '2016-06-07', 'Aktif', 4, NULL, '2023-12-27 07:46:55'),
('eb17a273-9912-46df-b9fe-4f015e2d3dc1', 3169862566, 4916, 'Gibran Arzanka Ramadhan', 'L', 'islam', 'Medan\r\n', '2016-06-10', 'Aktif', 4, NULL, '2023-12-27 07:46:55');

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
-- Table structure for table `tbl_tahun_ajarans`
--

CREATE TABLE `tbl_tahun_ajarans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tahun_ajaran` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `semester` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_tahun_ajarans`
--

INSERT INTO `tbl_tahun_ajarans` (`id`, `tahun_ajaran`, `semester`, `created_at`, `updated_at`) VALUES
(1, '2021/2022', 1, '2023-12-26 10:04:56', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_wali_siswas`
--

CREATE TABLE `tbl_wali_siswas` (
  `id_wali` bigint(20) UNSIGNED NOT NULL,
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
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `role` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active' COMMENT 'active/nonactive',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `uuid`, `username`, `email`, `password`, `email_verified_at`, `role`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, '782727f5-56d9-32a9-971a-317b108a5484', 'admin', 'admin@test.com', '$2y$12$KtIJ5ZKQefhp0n1UNM45TeXbEcUgxBzLdd.54K4U28x2ttFSYoYme', '2023-12-27 06:11:29', 'admin', 'active', NULL, '2023-12-27 06:11:30', '2023-12-27 06:11:30'),
(2, '0d0d43e8-12b2-31b2-8fe5-a8132b24b6a0', 'guru', 'guru@test.com', '$2y$12$dr4TP2dAVNIV7FnSW47TquJu6tXs7aZ/ftzod.E8UHyZ7DgTlOZmi', '2023-12-27 06:11:30', 'guru', 'active', NULL, '2023-12-27 06:11:30', '2023-12-27 06:11:30'),
(3, 'fd08b971-fb47-34dd-ab5c-f32191dcc9c0', 'siswa', 'siswa@test.com', '$2y$12$yI3N1b6VDMWHGp/VHTDQEO8sTDtDUPYwpVJhEbLVxx6mbCZy6.hUm', '2023-12-27 06:11:31', 'siswa', 'active', NULL, '2023-12-27 06:11:31', '2023-12-27 06:11:31'),
(4, 'ab557138-70cf-4f83-a75a-5316213adb9a', 'lindasitizulaikha', 'lindasitizulaikha@alittihadiya.com', '$2y$12$mAQAe5yr.6jyFs.cnBp2hOXGCOB8PLaVWxHFxhpN8E3F7ZJ2CIWeu', '2023-12-27 07:03:46', 'guru', 'active', NULL, '2023-12-27 07:01:03', '2023-12-27 07:01:03'),
(5, '3a3f150a-921f-4da8-8db8-dfadb9e21704', 'sitiwarohmah', 'sitiwarohmah@alittihadiya.com', '$2y$12$ruV7b1QGbqXHJX5euOPfCerT.HxzXzfkC3cR.ACXeteUgvdasUd.C', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:09', '2023-12-27 07:04:09'),
(6, 'b5e1574f-8e8b-47ca-9502-6be88db66d5a', 'andiputrabatubara', 'andiputrabatubara@alittihadiya.com', '$2y$12$dg7tDzlqhZLJhQ5zEq9.c.OJ5K2jw85AvHgDK7K2EE7YMrsBsZ8IC', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:09', '2023-12-27 07:04:09'),
(7, '487cfb08-7121-4a0d-84ad-03c61b125c92', 'alirahman', 'alirahman@alittihadiya.com', '$2y$12$T/JsIczqnT9eDCt.ytPIU.szs7lhtRKZAO7AFGYhTK31e2xEzTPO2', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:09', '2023-12-27 07:04:09'),
(8, '5a830f2d-eed3-4d3e-9eb9-52f477cea196', 'chairulazmilubis', 'chairulazmilubis@alittihadiya.com', '$2y$12$LVI..9oCsrUV2JCmFoeJsOMbrsQp4eybqp7c8WY5TsF.sKzXclmW.', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:10', '2023-12-27 07:04:10'),
(9, '6005d583-dd67-4b37-8d56-0b369fe466be', 'ririandrian', 'ririandrian@alittihadiya.com', '$2y$12$CRhDZWakJvBHM/bGjkjrBe5moAa5uOWNdm.RFKuzWgdyk4MzyDemi', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:10', '2023-12-27 07:04:10'),
(10, '30e884a1-8398-4b40-a995-537159fc928b', 'sriwedari', 'sriwedari@alittihadiya.com', '$2y$12$h8cl9mzVnNsFQ870w3p1v.0t1vsdQ.57OEjl7TbQ9kJDI/Pr7t4qi', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:10', '2023-12-27 07:04:10'),
(11, 'f09727a5-aad1-493c-87e0-78289a1017d9', 'nurliaayuni', 'nurliaayuni@alittihadiya.com', '$2y$12$S/UNI0f6KFUyZ/ksL78z1eabjHq5FsyhNSeWewmbHJWqlTB7LgMsi', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:11', '2023-12-27 07:04:11'),
(12, 'de33bd14-4be6-498f-a80f-c89487b04f6c', 'mariani', 'mariani@alittihadiya.com', '$2y$12$bQRfDKCXWsTAqL5lkxcVZ.FGc7o3uU9sYzldJXUftz9IL.PH/Y4c6', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:11', '2023-12-27 07:04:11'),
(13, '5e4cefe4-d24b-443c-b90c-a8881e2a8dfc', 'nahfazulfauziahharahap', 'nahfazulfauziahharahap@alittihadiya.com', '$2y$12$g.KD8I.uKE9IY/BkyzGaOuvH.ievS4Ur1avC7e/BVufNZdzf8RLl6', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:11', '2023-12-27 07:04:11'),
(14, '7e840fe0-a7a4-4007-b6ff-bfc4a0b9a24a', 'salmah', 'salmah@alittihadiya.com', '$2y$12$CgmQMd6IH9T2WXkwwf1gZuPi3AQEjtH2lhdf2I9hKvBgVB6qOZpoC', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:11', '2023-12-27 07:04:11'),
(15, '43e0d18f-e558-4e2c-85d8-ade37891ad56', 'susilawati', 'susilawati@alittihadiya.com', '$2y$12$lVgDvzUsdPGxUEln70JdiemU8.oslgWkOLDMAA8vSAJ889Bk6KlTi', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:12', '2023-12-27 07:04:12'),
(16, '81f0575a-babd-4114-86db-1ee183173f3b', 'lailyramadhani', 'lailyramadhani@alittihadiya.com', '$2y$12$TZl8o9JZ7KFIDPQEsHbEmuaQguRKF9S.4ag9pKwr7MnjkUxhwiWti', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:12', '2023-12-27 07:04:12'),
(17, 'e3d35d40-9d56-4d2e-b789-7639dd3da068', 'nuranisa', 'nuranisa@alittihadiya.com', '$2y$12$SR.3QwOrBfYEgcO/WEuHeOsLOMPzVG9YMa7mlCAtV/2a2ITMtWY1G', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:12', '2023-12-27 07:04:12'),
(18, 'b9a9134b-6ebf-4e00-887d-eccc5a825109', 'rudiahmad', 'rudiahmad@alittihadiya.com', '$2y$12$.2BQaJmOOsWEF0jqInUKreNgneaAPKssIMdPLIwsjWY87sRqjYo0.', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:12', '2023-12-27 07:04:12'),
(19, 'fb99357e-a162-4c19-a2d9-aac3e1d6d6b9', 'seriwahyuni', 'seriwahyuni@alittihadiya.com', '$2y$12$bGO66KlPB.oIQVZ9T2.6au0es34Q/AJ7OcO/v5rUbhwp7n44AsHmy', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:13', '2023-12-27 07:04:13'),
(20, '9a7aef3e-2c65-4bc0-bb2b-bcef6402f7af', 'masitah', 'masitah@alittihadiya.com', '$2y$12$oozxICu.XcC7m8OatTqZoeKa3QB0W9pdvgZO45FB84qp0F9XA7CJK', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:13', '2023-12-27 07:04:13'),
(21, '4d1289ec-59df-4cdb-9db9-0cf6233fca60', 'qatrunnada', 'qatrunnada@alittihadiya.com', '$2y$12$gHSs3J8u83vGUQ0PqfKvNOAWN/MeHDSFhYvnV9bJI./5JhSmkIUHK', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:13', '2023-12-27 07:04:13'),
(22, '0a4a121e-8dc9-4c25-aa1e-c05184fdecad', 'maimunah.bb', 'maimunah.bb@alittihadiya.com', '$2y$12$Ud8Ti91Ua8x0lDLxVTRUHunqZU.O2t2tAct8DGVt5dg.ACvi0Yjv2', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:14', '2023-12-27 07:04:14'),
(23, '7ea3bb16-ce26-4cc3-a9dd-86eee2b503b9', 'nuraini', 'nuraini@alittihadiya.com', '$2y$12$2Trgg1uPrA2nqZnmCsTD6u9o0k0devz6Db6Hko/giOjNNOeI0qrlu', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:14', '2023-12-27 07:04:14'),
(24, '2da75f18-9e09-4649-97e1-ea600e266183', 'alvyhayatinur', 'alvyhayatinur@alittihadiya.com', '$2y$12$2DK3zdrZTj.eCJiiiUhXJuLArTm42tn4/UupiTd8bCj8bosMe2O4S', NULL, 'guru', 'active', NULL, '2023-12-27 07:04:14', '2023-12-27 07:04:14'),
(25, '9a73e442-573b-4e7d-93fb-5dc31dbd5673', 'adam', 'adam@alittihadiya.com', '$2y$12$.zp7Ic/PxN4FGnxidPoq8ujBzwMCErvT8sOQHbK2FfzFiRY7r8YTe', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:21', '2023-12-27 07:45:21'),
(26, 'ed0bc63a-0d36-406b-b8f3-e2e0a80c0920', 'dillamahera\r\n', 'dillamahera\r\n@alittihadiya.com', '$2y$12$cxk5YnPrv7iNeACWKnbj4.T8uk.xJq88j5ipw0H79jZ6RNvxtyiGO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:22', '2023-12-27 07:45:22'),
(27, '9554c6e0-abc6-494c-aec6-75de4ba9fee7', 'rezadwi', 'rezadwi@alittihadiya.com', '$2y$12$XoGWbqzuUncw.wMhSClT7uRJWmWhttD2pyaMUtJMsjQQ/ztmZXQzy', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:22', '2023-12-27 07:45:22'),
(28, 'e91f706b-405f-45c3-95e4-62164ec63dfa', 'alieffrandika', 'alieffrandika@alittihadiya.com', '$2y$12$xlr2bvRpz4UkWcWy3/qiJeyj15cuDgb.zPp4PDH2YSj9X21B136ti', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:22', '2023-12-27 07:45:22'),
(29, 'a9296eb5-2114-488b-bd45-5e069122101a', 'ridhuan', 'ridhuan@alittihadiya.com', '$2y$12$BP0pF/BOPxF7yQ.J1xkAdOHqhVxLdYR2uYaNg6eJM9kK5mhH9EWJa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:22', '2023-12-27 07:45:22'),
(30, '6c9688ad-1f46-49ab-a86a-16d9c994327f', 'kamalmaulana', 'kamalmaulana@alittihadiya.com', '$2y$12$8Ke6aZUhV23sJ1wE3o1SHe3CfddQctL0qOlabyHWv0yKK6fFKV1cK', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:23', '2023-12-27 07:45:23'),
(31, '1e04db66-104c-4369-9eac-34512a4fd800', 'dinianggraini', 'dinianggraini@alittihadiya.com', '$2y$12$GiNBBBL5HLDC2z82f99bz.kwxlpskg39a.TnOqFyoc5R1HpLpIvkm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:23', '2023-12-27 07:45:23'),
(32, '8f008a18-8c61-49c5-8eea-7c62eecb3ec0', 'riskyaditia', 'riskyaditia@alittihadiya.com', '$2y$12$xjUadefyKti1SNqjKXNI3.U5pwj0InNiaAb3QWEwIPo/YvynR10OW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:23', '2023-12-27 07:45:23'),
(33, '9bdf9be8-f8fe-48f3-9976-832fcc722e90', 'fadillahahmad', 'fadillahahmad@alittihadiya.com', '$2y$12$SKzNxUPHtR.Q8BeNXQuI8OFCJvL.2dKeHEbUr2PHdQwUg1e5YVfgu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:24', '2023-12-27 07:45:24'),
(34, 'd7b89f49-d4f8-4c94-b59c-439ab6df1711', 'adetya\r\n', 'adetya\r\n@alittihadiya.com', '$2y$12$8pXIosGuKtUUoLct4VS7QeteDrcqU3JrpzijJ0Njultdixf8Gpcta', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:24', '2023-12-27 07:45:24'),
(35, 'dddfee07-c905-434a-9e46-ea19a8cc6ba2', 'kinantiputri', 'kinantiputri@alittihadiya.com', '$2y$12$rJlMn7/28QwgcJKX7CO55ejB3EEobbbv3skCzLfWJap/K8qUYm5G6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:24', '2023-12-27 07:45:24'),
(36, 'bd3b7bbe-9763-4153-be6e-adcd289cf4ff', 'irvankhadavi', 'irvankhadavi@alittihadiya.com', '$2y$12$iGxZcNf01t1pLr7N7TgEXup2fMFDO504IB6D3o01U5USh9Yyn1uKa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:25', '2023-12-27 07:45:25'),
(37, '36d1623e-7e73-4960-a114-2e52cbaebf39', 'alfianinowilia', 'alfianinowilia@alittihadiya.com', '$2y$12$c1IcgQ7y4KSe/xZcQNI6uemkwkOc5V.YnVrVrklf00qu3Na/FE0Ey', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:25', '2023-12-27 07:45:25'),
(38, '0fa40d3a-d3f6-4a12-a6f3-e70bf1404ead', 'harnitanadya', 'harnitanadya@alittihadiya.com', '$2y$12$lEVv4p505DgZ7arQvZECAeQakqOYg7t4HkSDPBWaiYKx9LH49r9nC', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:25', '2023-12-27 07:45:25'),
(39, 'a30f4502-a03d-46f6-b4f5-6602f464274b', 'alfathaprilio\r\n', 'alfathaprilio\r\n@alittihadiya.com', '$2y$12$WADsbIEx1C9bQyKAmxHfWOgMFdYd8qo2wX0UQ8lltSG34ALa5RB/u', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:25', '2023-12-27 07:45:25'),
(40, '949d3a5e-d985-41b5-866e-1c0f8f11135f', 'm.ahwan', 'm.ahwan@alittihadiya.com', '$2y$12$trIdpuZW0ZdvsxIR/Vued.66Ee4Qm6dRB4UQtGeIoK5pV8HpEy9QK', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:26', '2023-12-27 07:45:26'),
(41, '8442317e-d5a2-4c8a-819c-dc2c5dff1c4c', 'putrialya', 'putrialya@alittihadiya.com', '$2y$12$u7lwF76hfIblZTRaxysJ7OW7/f89oUYaoJ.lK.vlHuZSZ029o0XEe', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:26', '2023-12-27 07:45:26'),
(42, '18b19afe-496a-4edc-a085-34e4b8383e42', 'afikafitria', 'afikafitria@alittihadiya.com', '$2y$12$000SuR6C9Q7MZ7371GBj3uomhAXf/F.zU84RLrsyWoS3F6c1eX1mW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:26', '2023-12-27 07:45:26'),
(43, '4c84d253-ff69-4f26-8735-861f33aa829e', 'raffiqaradhila', 'raffiqaradhila@alittihadiya.com', '$2y$12$vu5u4pWPnQMb6DYirRUKDOq5Wi8q..QYtQTOEwrZAiuZ.A5jdiqfe', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:26', '2023-12-27 07:45:26'),
(44, '18aff587-55e1-411a-91d1-dad5b2cee055', 'm.arya', 'm.arya@alittihadiya.com', '$2y$12$l8mSutyh4grmM6Atpj4F1ePyWvM9UxNBLBwI468ZQjZjc0jOLR662', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:27', '2023-12-27 07:45:27'),
(45, '75193eaa-1b01-4033-ba28-fddfa10f3f54', 'ameliasyahfitri', 'ameliasyahfitri@alittihadiya.com', '$2y$12$TZVcrE4yDZVPdP5aUO9/cOBtRvSHfwW8.5smU6oqG/gFtcY2B7R.q', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:27', '2023-12-27 07:45:27'),
(46, '0a2ba194-85f1-4167-8884-10e69d091eb3', 'vindezacipta', 'vindezacipta@alittihadiya.com', '$2y$12$ic91JIyRIs1lxv3Xb2Ij.ukMcBkF0FYPNU5DJ4o.OXuUU7Jfwkeau', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:27', '2023-12-27 07:45:27'),
(47, '3d312830-1253-484e-92f8-aa6a23203a52', 'fadhilsyahnata', 'fadhilsyahnata@alittihadiya.com', '$2y$12$f2sP2d3q6yQxxchDIbB/cegXHMdbUUt0eDGlldGmUY6ea4/mTKwre', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:28', '2023-12-27 07:45:28'),
(48, '02c17f1f-505b-468d-a751-922dd766069e', 'muhammadabil', 'muhammadabil@alittihadiya.com', '$2y$12$ByurtjVHUyQGoGeWovvdauOKrhXO1hir.f6PE5zlg/9GKVR7x2V2G', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:28', '2023-12-27 07:45:28'),
(49, '55303be1-2045-4d1b-a8c2-44c98e7890ee', 'm.aditya\r\n', 'm.aditya\r\n@alittihadiya.com', '$2y$12$4A.CKB8BnHP2sFI6n5sVe.SVLMATqyvw3FTzCznxngOodovG6ZrJa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:28', '2023-12-27 07:45:28'),
(50, 'f1d1111d-b389-42b6-802b-2e58bfe3b9d7', 'ririndwi', 'ririndwi@alittihadiya.com', '$2y$12$Vs.zs278JGblEmD0fa86yuHj5cAfudk1FMBYjdy8ALa1IrWpJhszW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:29', '2023-12-27 07:45:29'),
(51, '88875259-b94f-4ce5-be8f-828c6b2caf38', 'revansyaban', 'revansyaban@alittihadiya.com', '$2y$12$JnKeycJByrc0CHLypJvRq.W1YF2h8zU7nSjgs81/mDB0xh.L0n4Gy', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:29', '2023-12-27 07:45:29'),
(52, '4ed21340-c456-4366-b6da-59303fe8d662', 'theodidik', 'theodidik@alittihadiya.com', '$2y$12$IJH4dMrX2jLdK/oT5hrvwuw3U5aUuAnTzHiYJc4YqNnQbpZt/ZJTO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:29', '2023-12-27 07:45:29'),
(53, '080dd632-e102-4421-9596-065765a14ac3', 'rapafanduwi', 'rapafanduwi@alittihadiya.com', '$2y$12$jFu8x3gDDGNzbOXubWLsPeQMftJEUrot3/YB92RQ9OI9rbEs1GEZ6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:29', '2023-12-27 07:45:29'),
(54, '705265ce-9385-42b8-891f-9510d138db74', 'mhd.rafa', 'mhd.rafa@alittihadiya.com', '$2y$12$C71sZXf/9AZPGdJn.qrVHO8CpyYjTrDP6r414qx9Ne.mSnSYHdxcu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:30', '2023-12-27 07:45:30'),
(55, 'b8a723ee-ec63-4243-a20b-b8f857edad32', 'fachriramadhan\r\n', 'fachriramadhan\r\n@alittihadiya.com', '$2y$12$0ONE2j6vEIGcjxASU.FUK.RDXI..QTP6qOd9/gbO1RBwR.DP/xpDq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:30', '2023-12-27 07:45:30'),
(56, 'bf13bc70-07ae-4caa-8795-8f9e06e3eda7', 'yogapratama', 'yogapratama@alittihadiya.com', '$2y$12$U0r0aX7fVu0trUWfXmhTguBEU50tgxbFCKdZZL9.juuiCjCifX3B.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:30', '2023-12-27 07:45:30'),
(57, 'a41ca3c3-b059-4bcc-94b4-6fb7fc9d5f95', 'mikhsan', 'mikhsan@alittihadiya.com', '$2y$12$oT0A/TCAkW6IJ6xo7b6/n.YxFugthvUI2MdwP7Tu3QcU6MaErve4G', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:31', '2023-12-27 07:45:31'),
(58, 'd5017c8e-71e4-4359-9455-72c0528d31b8', 'zakhyferdiansyah\r\n', 'zakhyferdiansyah\r\n@alittihadiya.com', '$2y$12$jtZcrOkDm8axpw2DHjeVo.jP0tsWwBGbAB/eh7ESKVKgOIi.xX91.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:31', '2023-12-27 07:45:31'),
(59, '3e6d938c-6744-4add-9378-7c528e39f876', 'raiqahrachmad', 'raiqahrachmad@alittihadiya.com', '$2y$12$hn4q41n.LWd2E7v8V6DVWO9Y6NEA56ZZC.gPUcJIvV06iCeB.U76.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:31', '2023-12-27 07:45:31'),
(60, '21b8acb1-a5d2-4806-bf41-a88262f4685a', 'nazwalutfiyah', 'nazwalutfiyah@alittihadiya.com', '$2y$12$yF8.XVUPMLY8..kj4ETGV.FXGNmn8F21e2ei4tzvNkKhH9brEdx0O', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:31', '2023-12-27 07:45:31'),
(61, '85933bf7-dda6-4f77-b4bd-7d161de0d9e6', 'azharialif', 'azharialif@alittihadiya.com', '$2y$12$ERnYqTHmJOSSDIWv1yrCyu8Y2OPglhmI07G4vi6Z8KgbkcsnEL1Gu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:32', '2023-12-27 07:45:32'),
(62, 'b4442ddd-e980-472b-845f-5e334b9aff65', 'dwiarya', 'dwiarya@alittihadiya.com', '$2y$12$JHySaqyBFpRxSl.7sq.KH.bGoAd48Zt0nLoLLGOIdc20RSnEa4blW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:32', '2023-12-27 07:45:32'),
(63, '909ff0a8-4837-4a15-bb9b-c7f75c1d7608', 'kaisadevilia', 'kaisadevilia@alittihadiya.com', '$2y$12$VjPjZn69l/7gxwPC30FYi.5op4Y5l2qkRj456lrIyVy3mVPrkjN5C', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:32', '2023-12-27 07:45:32'),
(64, '07ddbfd9-92f0-447b-8d56-eb3e83f85d44', 'bagusprasetyo', 'bagusprasetyo@alittihadiya.com', '$2y$12$H1CFImm38tdY0U4iVrU0UOkZWhwUkRc2ROpk8gAwbygY2fKJGTx42', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:33', '2023-12-27 07:45:33'),
(65, '22362aad-7ba0-4155-b2fa-3c852dfb5715', 'fadhilguntara', 'fadhilguntara@alittihadiya.com', '$2y$12$MOU0/yw.p5.SfIcFZOD/GOuZ4C5KcJmrN9Cco9Ly6E4FRuHWlWrCO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:33', '2023-12-27 07:45:33'),
(66, 'e894f7dd-438c-4cb0-bcf0-3d52609b98bb', 'hardiansyahreyhan', 'hardiansyahreyhan@alittihadiya.com', '$2y$12$K2yVIHNnDI7cKFI/qFSp5OMYXJPOGpPhPr5mTrUj3zVomEr/F/OO6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:33', '2023-12-27 07:45:33'),
(67, '8b05d144-000f-44a0-b002-859f522a8716', 'aliefpratama', 'aliefpratama@alittihadiya.com', '$2y$12$qI6T.EGM1c.e6vxv718SDOsWeb7G6sw8Kt/JuwvD1AbcbSzvdy.QG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:33', '2023-12-27 07:45:33'),
(68, '296b3133-e1fd-4a53-8275-22ec9498d402', 'mhd.alda', 'mhd.alda@alittihadiya.com', '$2y$12$.RlSerRHRdYTSgDjpichQOCjv1A1LjM4yFn6Y5swzKtin6sFvKf4i', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:34', '2023-12-27 07:45:34'),
(69, '0baef1ac-5328-4407-bfd3-0e9c8c3cd493', 'jelitamutiara', 'jelitamutiara@alittihadiya.com', '$2y$12$b.YkVC.2fq9GlMj9uxIpk.Gq2EJ8FhGbZfSp2krxeDQQDcKffNOrG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:34', '2023-12-27 07:45:34'),
(70, '7ad6829c-017f-4062-bf5b-7e851a0477a7', 'dwiattiqaah', 'dwiattiqaah@alittihadiya.com', '$2y$12$EEbOuFMHinu0Wm0/0NPLM.slLcj7y4aP.t.i8Oatwkww/mshgl1UW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:34', '2023-12-27 07:45:34'),
(71, '289831bc-6cc5-4bc1-aab1-2e49d5fb0597', 'muhammadazzam', 'muhammadazzam@alittihadiya.com', '$2y$12$.D6g1c/U4NTYjJXq5SeXG.SWw7DuBJ.ySBhxLdefZSivNyEivMxCS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:34', '2023-12-27 07:45:34'),
(72, '91ec6cbb-199d-46ee-8836-fe240d9a845b', 'muhammadabdul', 'muhammadabdul@alittihadiya.com', '$2y$12$VTJQyJdhyrqfQKEgmpsr3uY/6ITTd79SvvzIHP8KRT9maljLFPZ9S', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:35', '2023-12-27 07:45:35'),
(73, 'edba05d4-fac6-402f-bd81-f4ace625cafc', 'riziqakbar', 'riziqakbar@alittihadiya.com', '$2y$12$bD.oHK.s3G.YM3Qtrp7SQuCPiSZ3ejKkr8WesKmNE8kNRwPn8lDPa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:35', '2023-12-27 07:45:35'),
(74, '7da1af71-2a73-4108-a162-f77e127ae3b5', 'prabuarya', 'prabuarya@alittihadiya.com', '$2y$12$BYqdEUGzoPUOwlvAql0P8OA9icB1duB1yBEfeh97DmbYG2SUII3sq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:35', '2023-12-27 07:45:35'),
(75, '5d242fb0-9185-47db-ae04-a57a5b663217', 'cutnisyah', 'cutnisyah@alittihadiya.com', '$2y$12$792iBuOP.aBUTkV5skHGd.WYK5/pW9kgHQlFOXR4.caIoMk/S0dPS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:36', '2023-12-27 07:45:36'),
(76, '43f7b8fb-62ec-4196-81ce-80ef831ea40f', 'hazizah\r\n', 'hazizah\r\n@alittihadiya.com', '$2y$12$KoGPYKmxMOBe1FkFOYZEzuBvEuSWGMLQtHcIMv8Z96l8NUaIqOjYm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:36', '2023-12-27 07:45:36'),
(77, 'be0ddf04-c36f-471d-afb9-0ee2ffc75154', 'madaal', 'madaal@alittihadiya.com', '$2y$12$FpBN1XWRVvmcBWphbs5eKuw84HohzXxtH5wka4jOqlA8bEqFbRMye', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:36', '2023-12-27 07:45:36'),
(78, 'fb39ac4b-76eb-414a-9235-55282412c712', 'amarjoyo', 'amarjoyo@alittihadiya.com', '$2y$12$JTB9ura/6whtju6irM85V.31lX0XpHI/mS43fpYSBU4o6/qTCiruW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:36', '2023-12-27 07:45:36'),
(79, '2811b79c-b7d5-4218-9e7a-c6b1cc168d4d', 'rivansyahdewa\r\n', 'rivansyahdewa\r\n@alittihadiya.com', '$2y$12$x1PdT73uc.fEh5QHgieqrelBKJ5CZUy9uPK9cptOhcp/S79nUCqa.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:37', '2023-12-27 07:45:37'),
(80, 'b1f5c508-4787-42f4-b4a9-983b52351946', 'alifiaaishyah', 'alifiaaishyah@alittihadiya.com', '$2y$12$y20Yzz5.blC9IkUKHIPBY.Ni24aDhNn3xMd2dMB9NTzbb3r6934r.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:37', '2023-12-27 07:45:37'),
(81, 'b5845540-6542-469f-87d9-408cd61fb9a1', 'cahayabalqis\r\n', 'cahayabalqis\r\n@alittihadiya.com', '$2y$12$KDxWbVjmS2wJkBcSP2xRceTPzywhSsyvp7CV4/2MAhP1zbB4XZscO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:37', '2023-12-27 07:45:37'),
(82, '33252679-216d-4b36-9592-7c4fb7fd39f4', 'dirgapramana', 'dirgapramana@alittihadiya.com', '$2y$12$GnFs3vyUJAXRusfNfq7giOSBYye80qWwfNlarAyU8g50cgHxgX3Ia', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:38', '2023-12-27 07:45:38'),
(83, '0f1c524e-c9cf-448e-99ec-63c6070d237d', 'armadajaya', 'armadajaya@alittihadiya.com', '$2y$12$aGq4Mrg0sQ1Uf1zTgI7mSed9K9iNpzTSvY3z3b1Eu8N9aOuo8OLlm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:38', '2023-12-27 07:45:38'),
(84, '1ef49c9f-07b5-4bd7-ae12-ddd20f4aa8c6', 'kesyanabila', 'kesyanabila@alittihadiya.com', '$2y$12$WyAYcpTY9sjlLaYqLYXsY.6KYFtWTWo1a/jWWUR9wSlb7M3pD936K', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:38', '2023-12-27 07:45:38'),
(85, 'bbb1988e-52c8-4fa3-8265-6f669d679845', 'adibahmey', 'adibahmey@alittihadiya.com', '$2y$12$9GM.JmTCEPUtspurgL26euywKlP1Adt56CimNusRXr34ZOm04/5hG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:38', '2023-12-27 07:45:38'),
(86, '3a81d9da-3147-491c-846d-fcf4be161219', 'audyangkasa\r\n', 'audyangkasa\r\n@alittihadiya.com', '$2y$12$tpfcJtlXbS/OPceRq/ajpO2LOWFOvN7UrWebLeu7fpWuGY/lkWGZa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:39', '2023-12-27 07:45:39'),
(87, 'abfe3ccc-ae58-41ea-925d-c9e687b4dd25', 'ezaal', 'ezaal@alittihadiya.com', '$2y$12$2jin0pN6YOHfjvlcPzbwzOmiPY5lMskitN8Unslo1SdllqweoRusq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:39', '2023-12-27 07:45:39'),
(88, 'd0b122c9-e54b-4e36-a1d6-abce560679e5', 'rarairdina', 'rarairdina@alittihadiya.com', '$2y$12$x3F.ymZsBymW0sVNNv5VruHVIt7aZWf/IAAYg97ur7YYVQePLQb.G', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:39', '2023-12-27 07:45:39'),
(89, 'b417a023-0d4d-4b1a-b6e4-e9a933b80f67', 'suciamelia\r\n', 'suciamelia\r\n@alittihadiya.com', '$2y$12$aL662eEYgFpW3XFzXdp0H.gTc7oebJN0kkZ3IytHadKZb2YwL6pEu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:40', '2023-12-27 07:45:40'),
(90, '6ee22a26-d816-47cf-a1c9-0de39f607520', 'alfathanfredy', 'alfathanfredy@alittihadiya.com', '$2y$12$5bWo0HwrLEuQ/3PfvmeDoe//IPYdfDgQAKukUui.8XDmpfA8.jPFa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:40', '2023-12-27 07:45:40'),
(91, 'd32c88d4-7a78-4f88-8fd2-52c3ef5a9277', 'bungakhairunnisa', 'bungakhairunnisa@alittihadiya.com', '$2y$12$yokfkScM8C2NYkYCEhcQV.F1I6O.Gv.wuQ3AwCsVqmc5wPh6.3grO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:40', '2023-12-27 07:45:40'),
(92, '3b4fb793-bb27-437c-92fc-c5ae10a643d0', 'sheddiqraffa', 'sheddiqraffa@alittihadiya.com', '$2y$12$K5opq8rwIXu0y7qMBT0so.ac44tRWyPJlWzKQooPcOHP5JrpBwjiW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:40', '2023-12-27 07:45:40'),
(93, '69527ac7-0a9a-4a09-9c4c-87678be5f0b8', 'azkahuzaifah', 'azkahuzaifah@alittihadiya.com', '$2y$12$mvHRrxmF4m3AYCAfmMMp5uWx0c8JUp/PNkXgxtwfsUavJA6LYyd42', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:41', '2023-12-27 07:45:41'),
(94, '585a30a3-ec8a-4b1a-964c-f682eedeab18', 'syaqilladwi', 'syaqilladwi@alittihadiya.com', '$2y$12$51gabzi2rk3B8xB87UAsquAWE.aUw3DpncwlR8C2Eo7f6wFMV3qrG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:41', '2023-12-27 07:45:41'),
(95, '91deb553-7565-4a94-83f8-7f53287cea1f', 'habibi\r\n', 'habibi\r\n@alittihadiya.com', '$2y$12$kjZ6jPMfGgTmYzfzFvYbkuM17Yg2lArKwo4CNfILgb2KFrUVuYo3W', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:41', '2023-12-27 07:45:41'),
(96, 'f5971448-5160-477a-aea7-6a94a3194a7b', 'devilaramadhani\r\n', 'devilaramadhani\r\n@alittihadiya.com', '$2y$12$osQ59iZMwMS17k5eQ2OaEuC3lCt229rXm0s8dlrdEZ.ph7GL7Gfyi', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:41', '2023-12-27 07:45:41'),
(97, 'ade77dc8-e216-4f23-9cb5-5dcd87d6e605', 'muhammadaditya\r\n', 'muhammadaditya\r\n@alittihadiya.com', '$2y$12$clo7JpbppV3CGAzN.6bCR.uKmmaMnGPK7w6tGZDDKJzYiTNAnmor.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:42', '2023-12-27 07:45:42'),
(98, '755aaf5b-3abd-43f0-a213-c087bd01470e', 'anhukhairi', 'anhukhairi@alittihadiya.com', '$2y$12$Vi9ZVRfXS.w4cSE3OjP9a.tN3COJaI6dom4V9PUbjDyUmu0YDVyKq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:42', '2023-12-27 07:45:42'),
(99, '3b5fd561-4f84-422c-8c83-8b45a8416d81', 'nayraramadhani\r\n', 'nayraramadhani\r\n@alittihadiya.com', '$2y$12$XKtaxjZh8Mstj8id8gro7.wzTwhmXyinn6hp4nIIGmOUoGcOlzvEW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:42', '2023-12-27 07:45:42'),
(100, '3bb0f527-0344-4649-bce9-1dd88c7a296d', 'kiranakellen\r\n', 'kiranakellen\r\n@alittihadiya.com', '$2y$12$QV7Tn3/uSFGlDunDhhWvb.4zdVdy1BFdbx8RaDB8FejYrS4qui1.i', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:43', '2023-12-27 07:45:43'),
(101, '20587ce4-af8f-4b01-8874-289fa596e25d', 'muhammadriyan', 'muhammadriyan@alittihadiya.com', '$2y$12$HHakFjV.bk7.viAa29fjLewwhIxyk5Ym04HXkcByoWa9PrubrWdJm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:43', '2023-12-27 07:45:43'),
(102, 'ad830ca1-6342-4ea9-aa1f-6e74e5d6a180', 'nabillaaprila\r\n', 'nabillaaprila\r\n@alittihadiya.com', '$2y$12$njLudFCNyJpyaf4zZ6joIOzEXdfqppOTs4wGSIR0ua1SaG66x4RhG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:43', '2023-12-27 07:45:43'),
(103, 'f241bff4-2164-4036-aa47-8ec669fd3f70', 'nadienputri', 'nadienputri@alittihadiya.com', '$2y$12$bwnWiwzN9bkCbEKKmPu.N.TsQxylAD5LfQ4imc075mH4CvL3m.J.C', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:43', '2023-12-27 07:45:43'),
(104, 'ed12f075-0fa3-421d-83a6-86dc27a7fe99', 'm.zulfikri\r\n', 'm.zulfikri\r\n@alittihadiya.com', '$2y$12$VK47pnurih.IWGWPr461NuDcc33JLyNgK1y1FdkU1opz0yd/bijfy', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:44', '2023-12-27 07:45:44'),
(105, 'eeb66afc-b3b1-4161-a0d7-f7c835f14a77', 'amira', 'amira@alittihadiya.com', '$2y$12$JYmGrBe1lPIvbcmaJsHOv.TFgsSnF9naZNTWLe75byCkx/x4.e.sy', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:44', '2023-12-27 07:45:44'),
(106, '8bfd6ac3-042b-45d6-acf7-75ba601481f9', 'andikasyaputra\r\n', 'andikasyaputra\r\n@alittihadiya.com', '$2y$12$jnE4yg8847bsWMhUYn7RgudWl1QYpT1KjdoIWZjw5q9AHbDrO7M9W', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:44', '2023-12-27 07:45:44'),
(107, 'be020121-c531-48f5-85d2-6da550fe456a', 'aulianatasya\r\n', 'aulianatasya\r\n@alittihadiya.com', '$2y$12$.quTGRZJvUwCQfWyYhqyr.FE6Yw.YPmlkMhVEIWAzUkrls7EB/ufG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:45', '2023-12-27 07:45:45'),
(108, '1f960635-1f05-49f8-aa8d-67f034bc9566', 'kanayaazzura', 'kanayaazzura@alittihadiya.com', '$2y$12$gynwg7to8cDc/LLehWYdVuaYvSrNxRQya19T/5tZakfVq6kz7SuBu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:45', '2023-12-27 07:45:45'),
(109, '7ef5eef1-794a-4a27-8909-7e07bf467774', 'bimabatara', 'bimabatara@alittihadiya.com', '$2y$12$XtI.eBu6nJsXdRADacTaYOheDkWuM6waTlzn8gFa34ZFEEMRseUty', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:45', '2023-12-27 07:45:45'),
(110, 'bafb410c-130b-4b47-a281-d65721184c6d', 'ranggapratama\r\n', 'ranggapratama\r\n@alittihadiya.com', '$2y$12$wqE6xPwllxtm6Z/XKWSWW.j59mwYs6Rx.LiwcLfeEJg.Zo05Iwb12', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:45', '2023-12-27 07:45:45'),
(111, 'bdcf9512-b401-4df3-9860-c4a2adfd40ad', 'assifasyakira\r\n', 'assifasyakira\r\n@alittihadiya.com', '$2y$12$26v9QXcepuvKGFOtgk8GueCOrngeiPzVmZI0lXF6z.ZwV49rOdz2m', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:46', '2023-12-27 07:45:46'),
(112, 'a58d2b0b-ab0b-411f-9730-4459034d43cf', 'putrianita\r\n', 'putrianita\r\n@alittihadiya.com', '$2y$12$S18dvYpQpItvCj3dpfgV2e2485zCFdq5fQ6C2x8DGtt2r5sOT.TVG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:46', '2023-12-27 07:45:46'),
(113, 'd047ad21-a12d-484d-a0d0-607c5993500b', 'ranggaramadhan', 'ranggaramadhan@alittihadiya.com', '$2y$12$sje0Gf.wSZ.4thn149RpJ.RDUCJyUCRMfEpG3O6mzZY8D9GHBYA2q', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:46', '2023-12-27 07:45:46'),
(114, 'be6af6da-eccc-4301-a407-d92794988b1c', 'inayahalifia', 'inayahalifia@alittihadiya.com', '$2y$12$nnBejuy0zQ3xdvOu1MEfjuiSpigw4wR9Hz7Msgqo12xxIbiix5bMy', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:47', '2023-12-27 07:45:47'),
(115, 'fefe8fe9-3616-406d-ac4b-f9792fe95751', 'fahmifahrezi', 'fahmifahrezi@alittihadiya.com', '$2y$12$4Heo3e5OgmxF6DXfui13fu7exFQCnyOO2KmcqIXVyecuNfFz.cCwm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:47', '2023-12-27 07:45:47'),
(116, '8e4373a0-a932-4540-ae09-c3faa784925f', 'almushawwiru', 'almushawwiru@alittihadiya.com', '$2y$12$zGFP2tMBRyQX7P7olvRFkeep9Fc92l2ATzQ5a0edK.YHSYsJfltlm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:47', '2023-12-27 07:45:47'),
(117, '9817bf94-8ffd-4b0c-b5cd-75d03c165263', 'anarkhy', 'anarkhy@alittihadiya.com', '$2y$12$FsFwGD6jiwVVPByV8jq16.P0aHks3YPsDaREdFNOxXEDb98ogvsOG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:47', '2023-12-27 07:45:47'),
(118, '6481b904-eae0-400a-8610-45654b21e810', 'muhammadalhafiizhi', 'muhammadalhafiizhi@alittihadiya.com', '$2y$12$pdq3wWFMtumQUFBScSZpp.5YI8EAMnysvxGTSMdqzg9Gf6RvvMUzG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:48', '2023-12-27 07:45:48'),
(119, 'e02d3339-308b-4efa-b920-803dcd5ab23a', 'indriaulia', 'indriaulia@alittihadiya.com', '$2y$12$jKONsHIcgckEiXHCeXaS3OILWizFcb767Q/iD4BqfI3RwVIpdQaP6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:48', '2023-12-27 07:45:48'),
(120, '92f0c6a0-1716-4f23-9670-1b662d7d031b', 'putrysry', 'putrysry@alittihadiya.com', '$2y$12$K7iWwqVrByCD/nmfB1LEe.Yam4PV93rwFKyTDTbQuZnJVz8EUflIS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:48', '2023-12-27 07:45:48'),
(121, 'ec33a2df-ca5f-4eb4-8912-5e880b497170', 'khairunisa\r\n', 'khairunisa\r\n@alittihadiya.com', '$2y$12$gedNPrgP.f6x1361TxHMC...DWuZDYvWh9zKkh6HxzhuNLazTb3Y6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:49', '2023-12-27 07:45:49'),
(122, 'cb5cd791-6458-4632-b3f5-cd06278fc4d3', 'muhammadfajar', 'muhammadfajar@alittihadiya.com', '$2y$12$jDDV8DPlf6FDxyaEDpqK2edb5qba4h/gouv9mIs1UWWyNai2HWo1O', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:49', '2023-12-27 07:45:49'),
(123, 'c4e8ae18-7910-4bc4-8890-ca1da3220838', 'abdiriski', 'abdiriski@alittihadiya.com', '$2y$12$VRoXZc2WkDo5BIlJi2TMSu2sqhelPvaRFGnPdQVE7nkLXeJcBDrPK', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:49', '2023-12-27 07:45:49'),
(124, 'e068bf0a-de01-4e82-90fb-f35483f6b85e', 'miftahuljannah', 'miftahuljannah@alittihadiya.com', '$2y$12$qWJqcFZiXaRwfeDDnvUZBOV9H2KU4nk.pbk5Q/AU7N0TqQFJ8JOoO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:49', '2023-12-27 07:45:49'),
(125, 'e2518074-924c-4663-94a6-4247d381c2c6', 'alfinofajar', 'alfinofajar@alittihadiya.com', '$2y$12$FjcT6IF7XFZ.rk8nDk2mkOLh7PHfEinFLMI3hUgqHBgmyUBs8.igC', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:50', '2023-12-27 07:45:50'),
(126, '04c9cb9b-4d7d-4148-a72c-dea8ff048cdd', 'rizkiramadhani\r\n', 'rizkiramadhani\r\n@alittihadiya.com', '$2y$12$10A.NVaPgTeYcjQTh6YTE.C1cmBsieF9rJs21ZsMJgzlGsdSUOV5a', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:50', '2023-12-27 07:45:50'),
(127, 'caffd2cd-aca0-49a7-9c3b-dc29f48d1a11', 'aziizjamiil\r\n', 'aziizjamiil\r\n@alittihadiya.com', '$2y$12$AZ1UXgl7tp815LXqc9RMAOdyFQqiZqG9e2XigY2me2i8JcHrsrSwK', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:50', '2023-12-27 07:45:50'),
(128, 'b78ed89a-d742-410d-9539-54fd28383ee3', 'bintangmaharani\r\n', 'bintangmaharani\r\n@alittihadiya.com', '$2y$12$Dx8z5YeLaXmawkDDhTiZ7eTVPmlRsT.t1PA13ld/c58ya4bGYYEny', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:51', '2023-12-27 07:45:51'),
(129, 'cf0ac4e7-3f36-4745-976b-287785ed9549', 'muhammadrianda', 'muhammadrianda@alittihadiya.com', '$2y$12$2b04wHrrY0JNtO9d.QpGbuTCFAfyoApTPKTHr3sf96T2IkB6au8QS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:51', '2023-12-27 07:45:51'),
(130, '6e28ca41-3def-4a41-8086-234686dbc464', 'raisakhairani', 'raisakhairani@alittihadiya.com', '$2y$12$jjhHks4CZ.yHeDezJJ8qBOTy.jAZRzLZ73QuRBl6BrEaZ8c6yTuJa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:51', '2023-12-27 07:45:51'),
(131, '848a2424-c73b-4310-8e47-e2f3a9e9fe52', 'riskialpian\r\n', 'riskialpian\r\n@alittihadiya.com', '$2y$12$s.11AkX5TQ5GHjx.3Hbx9.SAkSlI5bjdZe4Gz2yR7h7u.fSFyRuum', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:51', '2023-12-27 07:45:51'),
(132, '8ed4f202-87a1-46ce-aa78-4de527e7373b', 'ramadhanhusein\r\n', 'ramadhanhusein\r\n@alittihadiya.com', '$2y$12$C42UCzr6RNK.61Ghs2EWwuo3crK/qtfqx.HgwRaFH5uYtCnyppUp.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:52', '2023-12-27 07:45:52'),
(133, '94a85cb6-707b-44d7-958e-74ee1a49b300', 'sucianggraini\r\n', 'sucianggraini\r\n@alittihadiya.com', '$2y$12$pT/EKTJO9n5/0s4PdefG9uUftSBW9QIQl0VG65jZG/BxujNFwXDTq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:52', '2023-12-27 07:45:52'),
(134, '4e062042-6e46-4fc6-8b63-1dc33ac910f8', 'nabilasyakila', 'nabilasyakila@alittihadiya.com', '$2y$12$LV.K2hNextmSr7NgYxOwpuIhP1bqWDlhiRyqjPIf0XP/.M85Jmvxy', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:52', '2023-12-27 07:45:52'),
(135, '2eb164fa-0aed-4e60-a7d8-e7183e0a901f', 'egiherdiansyah\r\n', 'egiherdiansyah\r\n@alittihadiya.com', '$2y$12$cMAR2rpVAV/n4rWtQ1Z/p.uTtOSNFhIVWnHt.vyy.W9rMgBH9ob.a', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:53', '2023-12-27 07:45:53'),
(136, '89979491-9991-4192-ad8c-9aed4ee5d8a9', 'triaurel', 'triaurel@alittihadiya.com', '$2y$12$4eb5G5H3dOlMkLx1qfhiSu8d4hlbEbB0LEFQ3jUxgq74VTsLApLwm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:53', '2023-12-27 07:45:53'),
(137, '16b5340f-b23b-481b-8946-35be1ba90fb5', 'syifaamelia\r\n', 'syifaamelia\r\n@alittihadiya.com', '$2y$12$NOaEiO3uqgd9eUMlrvmNBONl4qLhStiv0XiEU4F59bQQJdnt4ZJou', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:53', '2023-12-27 07:45:53'),
(138, 'ae34e80a-f742-4c91-bee8-f9a3826e6117', 'faridazhar', 'faridazhar@alittihadiya.com', '$2y$12$p863s6PLqOCO1lDbzIs.SuhS52W3IX4oXdHPkXL1xOTfIrQc3VqUi', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:53', '2023-12-27 07:45:53'),
(139, '8338cb06-570e-4665-a38b-ee701eef50a2', 'bimbialamsyah', 'bimbialamsyah@alittihadiya.com', '$2y$12$ByMigkgd3ZOLHRLyWE4s7eCijuThgp0L02vEKDaEjmNjAP/9LeqNW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:54', '2023-12-27 07:45:54'),
(140, '0764bb95-8947-4e89-8b1e-c7b8745143e7', 'wirafitra', 'wirafitra@alittihadiya.com', '$2y$12$XgoI70jkisu9PgEMQG6PAuntEWZ2Rqr8wgupvR6gixb5jyW6UkNJa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:54', '2023-12-27 07:45:54'),
(141, '7f7274c1-66f4-44ff-a5fb-40ea6eea2b7d', 'aprilliyagusnana', 'aprilliyagusnana@alittihadiya.com', '$2y$12$1CLk.hozKtqmbT828BtRs.FQEprleAdrUIuGWIOPPus3AL0cP2PLa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:54', '2023-12-27 07:45:54'),
(142, '3b1b3023-3f10-457b-bd22-32e06fa7cdc1', 'hadiansyahputra\r\n', 'hadiansyahputra\r\n@alittihadiya.com', '$2y$12$wSuFnsEaL6ZbMTBrEF8SLO5u.42uR2FG6sJrgv5iFY0jUGT8Kh.fe', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:54', '2023-12-27 07:45:54'),
(143, '5d909267-85c3-4cf5-b7b6-5840f77b8953', 'putrianggraini\r\n', 'putrianggraini\r\n@alittihadiya.com', '$2y$12$fvF8uhznOvpq9vSxDVCiiup6XvzmEVdmEviPADI00e5XgKQkzyLeW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:55', '2023-12-27 07:45:55'),
(144, '1cea14cb-734d-4004-a7ca-85d1f9726726', 'sofiahsolehah\r\n', 'sofiahsolehah\r\n@alittihadiya.com', '$2y$12$X4XyR5mgtNg5sqJgCJPe1O4ziC7mEUy/73WHKK8P1.MEttPLEgJuO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:55', '2023-12-27 07:45:55'),
(145, '414205a8-fd0c-4ca2-bb45-3df1774cca5d', 'm.bagas', 'm.bagas@alittihadiya.com', '$2y$12$R/L0vfPlA1bZCaNjVQQiBOmTcXJtT/nUw9Muhkdl3ZaI1SGOy066y', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:55', '2023-12-27 07:45:55'),
(146, '18aed56d-300d-4819-90fc-a28676b34f1e', 'muhammadfarid', 'muhammadfarid@alittihadiya.com', '$2y$12$5LQyDDudVoz.U8BPSJI39.qVzz9AdTehl290ZoseKhzT54T3tUJPe', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:56', '2023-12-27 07:45:56'),
(147, '9a040918-adae-457c-92aa-a1d57432aa4c', 'febrykatriani\r\n', 'febrykatriani\r\n@alittihadiya.com', '$2y$12$0K7imYEBdtwYAhFz8aB3AOOEu97uT/aSOWNZzRhSCSkhP9UUlWNxC', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:56', '2023-12-27 07:45:56'),
(148, 'f16391d4-7c5f-418f-868b-06769bc63082', 'dafapratama\r\n', 'dafapratama\r\n@alittihadiya.com', '$2y$12$yQ7ktiX1CzxSj9CKFtEuC.uUl94d29rSY5/kDXRebeBPLlHl1slKO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:56', '2023-12-27 07:45:56'),
(149, 'bd19b41d-ae83-448f-b49f-b9c2360c3e0c', 'rifqi\r\n', 'rifqi\r\n@alittihadiya.com', '$2y$12$QWTGOuZwlrqyNHh5uKZ9g.Y1oYshEe55yt.utoffGbEukgliyB/jO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:56', '2023-12-27 07:45:56'),
(150, '11eb6110-c4e0-4aff-a35d-af7e5830d880', 'fairahnaylatul', 'fairahnaylatul@alittihadiya.com', '$2y$12$0jb3o5zPbbAsHGvO2jvbPeBLzAYQTooGiwtmMCVvKTQq3QaQXCY7K', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:57', '2023-12-27 07:45:57'),
(151, 'f9292cf3-9e0a-431b-96bb-76f6203f53d2', 'gilangalviano\r\n', 'gilangalviano\r\n@alittihadiya.com', '$2y$12$mqeWclWSCeCw4fu2cZ9YRu7RGfv09zwArJtNFU7B1vXXbYSTMz106', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:57', '2023-12-27 07:45:57'),
(152, 'abecc602-05f3-4101-bd4e-0053d84ff62b', 'feroal', 'feroal@alittihadiya.com', '$2y$12$n14wBzqixF3hqpzmVfm3c.o33zWNGDuLNLlom2FaYe.cRmVYUx4Fm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:57', '2023-12-27 07:45:57'),
(153, 'a41f0da8-57f9-499b-b59d-32a25a0656d4', 'cantikaputri', 'cantikaputri@alittihadiya.com', '$2y$12$jtIq.OvyXN8G5BTi8rA1qehf4w3RWtS/vfcUOerBPN3oPuNpGG4Zy', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:58', '2023-12-27 07:45:58'),
(154, '56dcddda-f377-4abf-beb6-1bba53a90bc5', 'sanicah', 'sanicah@alittihadiya.com', '$2y$12$AWowQPlRfTqZzoJPzH47GO270Yz2RSS2OybQtOdmTNWnOGVviBtEe', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:58', '2023-12-27 07:45:58'),
(155, '086c5601-dbb2-4cdf-8193-7e993a35c2a2', 'alifarizka', 'alifarizka@alittihadiya.com', '$2y$12$jqPrwoN/B8kdKkbL/OyVieliZvqzFfv/nAQMkLP/DacZnRS3bzyWm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:58', '2023-12-27 07:45:58'),
(156, '5da57a04-755e-4370-a783-7020149b4754', 'aisyahsafriani', 'aisyahsafriani@alittihadiya.com', '$2y$12$qBSkry73uRDMvowFT/ulZ.w23NyLGKl66g2UVnP2G0U7370Ynhsxi', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:58', '2023-12-27 07:45:58'),
(157, 'ce375c48-efdd-4af6-90fc-c3c317bb6803', 'muhammadsaddam', 'muhammadsaddam@alittihadiya.com', '$2y$12$OHg60sq2RWu3MGziQKXJHu6jy.Reia12XlbFn1KvtKis3bo4oxJne', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:59', '2023-12-27 07:45:59'),
(158, '60138ea0-c0d3-4eb2-9b10-3a4b0dc5a7cd', 'afifahmahira', 'afifahmahira@alittihadiya.com', '$2y$12$6kMME6PL0LKl5Mk0JcY7hOMK.iko3/Y//8rn6CCOd2myYQunjtEpy', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:59', '2023-12-27 07:45:59'),
(159, '929dcd62-0783-42a0-8aa1-51ca5dd8ad50', 'aufaal', 'aufaal@alittihadiya.com', '$2y$12$hekzCp6lD08mc/Vi3lVS1eBs02qmlX1g.i7q17jTW3LFO2NN7oo/y', NULL, 'siswa', 'active', NULL, '2023-12-27 07:45:59', '2023-12-27 07:45:59'),
(160, 'a5ed8373-6253-4e8d-b193-d4537dba311a', 'fitrianjani\r\n', 'fitrianjani\r\n@alittihadiya.com', '$2y$12$kpy6eSUJtwkhwYqrkLnOoe16mslM5MEXdpPjLj2thXAt43cOdKdhm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:00', '2023-12-27 07:46:00'),
(161, '10f1c84b-6e85-4055-b1e8-fbba8c52710c', 'joreitasembiring\r\n', 'joreitasembiring\r\n@alittihadiya.com', '$2y$12$YbZImWXSnOjwiE6Ypudp5.YVqyY3TTQA0IajKGWf3jy/ScuED92I2', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:00', '2023-12-27 07:46:00'),
(162, '95727e5c-7c2d-440e-9573-d885d3730d8e', 'alyafebiyanti\r\n\r\n', 'alyafebiyanti\r\n\r\n@alittihadiya.com', '$2y$12$AUcJkLj0fO/R2uG.p4a/Iuw7gIHBBnPzzdbRmboJZGmXzbiZKnkzW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:00', '2023-12-27 07:46:00'),
(163, '5b34c507-f803-4442-bdc9-b487ec439854', 'anugrahferdiansyah\r\n', 'anugrahferdiansyah\r\n@alittihadiya.com', '$2y$12$xlBMc5jf24jvVeTeC82z6OVugTySYYOiGozL4lgBq5qHAD.6WvA8u', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:00', '2023-12-27 07:46:00'),
(164, 'e2219f3f-8c37-489a-a949-374820f8cd26', 'darudwi', 'darudwi@alittihadiya.com', '$2y$12$/LzKJmjH1jcAP8q4Z.tSxe8G/UmPY3w60A7aPrttqEVCnPY5LDjd.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:01', '2023-12-27 07:46:01'),
(165, '367d42dd-1366-4c09-bd2e-f2bf997571e7', 'rizkyperasetiyo\r\n', 'rizkyperasetiyo\r\n@alittihadiya.com', '$2y$12$FtMIUsCKgAyKfgrGEfqEBuWNaGBr4cdr0hT3pOpVptQ779Tqu5Uoi', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:01', '2023-12-27 07:46:01'),
(166, 'e67d643d-94ab-4b92-a976-2e11bcf6cd47', 'mhdfarhan', 'mhdfarhan@alittihadiya.com', '$2y$12$T9ufMQY802APLYKbf2Uv7Ov.EZdBDAomSnkl9Yb2a7QZbYCnB.ssa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:01', '2023-12-27 07:46:01'),
(167, 'fbf89cfd-13f1-46b0-9e70-36607051c05a', 'fathananugerah', 'fathananugerah@alittihadiya.com', '$2y$12$.lKzpMZUJW75sXW8X825/ejBCfX.9anteZZRUukPhU/xWHtLbBhea', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:02', '2023-12-27 07:46:02'),
(168, '40150946-c3a7-4943-8b79-ad0fc6c57ec8', 'lasmanaprasetian\r\n', 'lasmanaprasetian\r\n@alittihadiya.com', '$2y$12$aWF5iclGQwsAMbOYYOVOgOXDkvLDKV.WlLGZR82Rv6bgVLggxg99y', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:02', '2023-12-27 07:46:02'),
(169, '967e8b44-1d80-485a-a8d0-46df756e3679', 'm.yusuf', 'm.yusuf@alittihadiya.com', '$2y$12$vr/rZm4s5g9dQuUljpARJ.Ku0EZxO2zrnRxReo.UuPQq9t66jx7Fi', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:02', '2023-12-27 07:46:02'),
(170, 'd08d5b90-dc83-49a4-9b45-529a12a61745', 'nurain\r\n', 'nurain\r\n@alittihadiya.com', '$2y$12$kaXjSK3HgXvWxbQyR.6cMuBi5CV9DXdX9cMHFPlaYWGbtdXQs6HfK', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:02', '2023-12-27 07:46:02'),
(171, 'e1a3735d-0306-4a30-982c-abb9b243c2ba', 'ayundaazzahra\r\n', 'ayundaazzahra\r\n@alittihadiya.com', '$2y$12$Zd.sl/FmciN0Ky1EG3kVI.BeGcMxEAI.vEbEu89CXU25IxzzSISx.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:03', '2023-12-27 07:46:03'),
(172, '2ab707c5-1be8-489c-9b28-929f0b5668d9', 'muhammadalduwin', 'muhammadalduwin@alittihadiya.com', '$2y$12$yjnp8KaD.JN2y0i9oSSCgeURxkOLLDvbyCmlfRO1SDJ6OMMElJZEq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:03', '2023-12-27 07:46:03'),
(173, '7cdc9422-c761-48ce-9a00-82ccf9b27959', 'dyofebriansyah', 'dyofebriansyah@alittihadiya.com', '$2y$12$6ZDImsSIYQBP3f7bwrlnSeschKHu9DijYDdb98506UDWDWwZE/ZOq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:03', '2023-12-27 07:46:03'),
(174, '3acd8aa5-8d46-4ea7-93bf-c60e59c1375f', 'sucidafina\r\n', 'sucidafina\r\n@alittihadiya.com', '$2y$12$RgekM3FwO//u.9d.tYWRO.NNp3O1JYwqWC/KC4ZTwA52KokG0iIxK', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:04', '2023-12-27 07:46:04'),
(175, 'f7c73513-568e-475a-9b99-d1f52bec2eff', 'aidilakbar\r\n', 'aidilakbar\r\n@alittihadiya.com', '$2y$12$NNJWA5T5YS5AmT2.TThpM.ZRiWhDSlTuS0eSqK1OgtKUpd7fJ/m56', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:04', '2023-12-27 07:46:04'),
(176, '32adf643-566b-471c-8d3e-c7134dd2b7a1', 'muhammadkrisna\r\n', 'muhammadkrisna\r\n@alittihadiya.com', '$2y$12$65Xn0ymCEEuU1sgkjhHL7uLQefT6a80hOwcUKZkYQT5RhnLVcWFbq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:04', '2023-12-27 07:46:04'),
(177, 'a3478d0a-e0ec-4db0-8d37-0db3de9c0e1b', 'muhammadrasyid', 'muhammadrasyid@alittihadiya.com', '$2y$12$T2oAqalfiFt3GTQLBpr5EODrfSyCA8zEWVeTWW/Hqx7o9G2K7SPfq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:04', '2023-12-27 07:46:04'),
(178, '85eed457-061a-4458-a174-76c4bee86fa5', 'hamilahhabsari\r\n', 'hamilahhabsari\r\n@alittihadiya.com', '$2y$12$vJoawvNbbu21bORim4zj3O2rqt6zVYsegIIAxtsOX8WESJIDYTk9S', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:05', '2023-12-27 07:46:05'),
(179, 'f31c8225-da49-46ed-af13-d7cf336aa2c9', 'naylayasmin\r\n', 'naylayasmin\r\n@alittihadiya.com', '$2y$12$rIJzdAWSLdOIC18JGwvLYunUkErcZnzKMmj9ATsMjuBDpJ0v4oa0i', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:05', '2023-12-27 07:46:05'),
(180, 'fd2cbe73-9522-4b79-956a-f97c06ff8642', 'muhammadgetar', 'muhammadgetar@alittihadiya.com', '$2y$12$vATmo9LJhljlCIGdTz9GMObdF2d1EpwcgtcY6JfB1qUK2pKOkNUJS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:05', '2023-12-27 07:46:05'),
(181, '8de6c94f-199d-43f7-b96c-55c63b6ebd83', 'ainatalita', 'ainatalita@alittihadiya.com', '$2y$12$rDuFi1lNMs6P6bNbuyvt/OFBJEDJVo/q4UJfNRKR87.cHpaoQarNC', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:05', '2023-12-27 07:46:05'),
(182, '3f1bbbf1-99c9-46a7-9ee2-93cb361f9493', 'rahmaddarmawan', 'rahmaddarmawan@alittihadiya.com', '$2y$12$tbRLFV9sMo1JjJ.inW8zk.7SMZXM0R6zNW6g2.7CQQvXRH1zSA/6.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:06', '2023-12-27 07:46:06'),
(183, '51945012-445a-4eca-99b0-1f20a80ac3fc', 'nurineiliyah', 'nurineiliyah@alittihadiya.com', '$2y$12$LTFNwIdkVygsLdO1W5c7FOx9Wq2j50zv9HIdnjAMFgKVWixWYSpv6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:06', '2023-12-27 07:46:06'),
(184, '98279303-9709-44c7-b479-740e001b327d', 'muamarzain', 'muamarzain@alittihadiya.com', '$2y$12$cx38NGxdfGYnyKMHQvo.NuhtgrRp1ZDXH15JnK3HhGOTksYezwLQ6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:06', '2023-12-27 07:46:06'),
(185, '8ccc45df-d744-4138-a658-d27155dfa4ba', 'aqilasalsabila\r\n', 'aqilasalsabila\r\n@alittihadiya.com', '$2y$12$h5nFyAajrUEQxzM9S8fKs.gIycBAXfL1oaxV1W6pDnNsaoUEVkofq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:07', '2023-12-27 07:46:07'),
(186, '04f6e56d-f84d-4d2b-869e-3d8f8679d22e', 'muhammadalfarizi', 'muhammadalfarizi@alittihadiya.com', '$2y$12$/P3AMBLpvOoRuOwNNXvjFeD4n.7p1v6ad23lqFntDefDCJ73P1Q3O', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:07', '2023-12-27 07:46:07'),
(187, 'd454f6c4-da0a-4832-a05c-3a6e4a08e7c8', 'bulanramadhany', 'bulanramadhany@alittihadiya.com', '$2y$12$gtZSI0E99dfgrZ1G.BdApe.VF02NdlSqhXX1hpu7wjw57Otz4vg8a', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:07', '2023-12-27 07:46:07'),
(188, '2aad77f8-ab47-4024-af6a-6f28a40c2fdc', 'padlifadilah', 'padlifadilah@alittihadiya.com', '$2y$12$0N.4keU7Ag0eGRERW/juL.EpLpCna3Fi6tuoIv/aJFp3hZRbBOub2', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:07', '2023-12-27 07:46:07'),
(189, '75ecf623-55c5-4c28-bd06-29e79c8f56a8', 'azmiaulifa\r\n', 'azmiaulifa\r\n@alittihadiya.com', '$2y$12$blqhhuNvwPmqZ5PwcOhn4e8P9fLeCNUS5PtlNt/qHOLmjekF6y.GG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:08', '2023-12-27 07:46:08'),
(190, '164a20e1-4f9d-4df0-a06f-cac1781b4c12', 'najladwi', 'najladwi@alittihadiya.com', '$2y$12$sW/4ZIxvgQLkMDqf.v2mourJHB7ZWKcbT69D0ykRwWxH3ixNKUm7G', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:08', '2023-12-27 07:46:08'),
(191, '58e87bd2-d3cc-4511-944f-885a54698740', 'nurshina', 'nurshina@alittihadiya.com', '$2y$12$rh6r0bH3lzVaXownc1D3C.CymIgabFV/qaDpDZVwWEgiaVk2gd.Q2', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:08', '2023-12-27 07:46:08'),
(192, 'c2686023-b7c4-4a06-8f8e-892a55543804', 'fachryluthfy', 'fachryluthfy@alittihadiya.com', '$2y$12$0h1CCDIn9nwom/gZqVghg.zUkz9jlrZ2b6JYsCgEWyNmOf7wkID6e', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:08', '2023-12-27 07:46:08'),
(193, '15201c2b-cd41-4a2c-81ae-102cd05e34e9', 'wiladatul', 'wiladatul@alittihadiya.com', '$2y$12$536hoETRzeDNyUC5Ya.gzufFsP3EPx5recHQvVLxV6VtgmzI.1Utq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:09', '2023-12-27 07:46:09'),
(194, 'be67df20-f3fa-41f6-842e-e47ff22f9dc8', 'muhammadazrul', 'muhammadazrul@alittihadiya.com', '$2y$12$DVgD5eq//.kWvuM5gpZAT.uVc56EMae9T14lKEW22mDh0zwPMKYtS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:09', '2023-12-27 07:46:09'),
(195, 'fe6bb619-c881-40d8-8b41-144fc9ffd92b', 'm.dimas', 'm.dimas@alittihadiya.com', '$2y$12$5Qw9uATWEH0qnvP0pEE8IuM8HCx1JnZ7B/QSA/T6bBZWq/He5m3wO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:09', '2023-12-27 07:46:09'),
(196, 'a8b195cb-b7c8-45e1-9ce7-8657d36ea3b9', 'tirtaardiansyah\r\n', 'tirtaardiansyah\r\n@alittihadiya.com', '$2y$12$lca/jmhnL5Q8WtpHTh1OG.nTMqwW1Y.SrcdI2XJ2QWHKTHHbs2od2', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:10', '2023-12-27 07:46:10'),
(197, 'a67ce466-9ce3-49e6-b823-66e918d630e2', 'nazlaqanita', 'nazlaqanita@alittihadiya.com', '$2y$12$fkiFbucLeuVpwgyC226VIu8XyWTSfPrabnwZy6taM3x3manjIRkDW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:10', '2023-12-27 07:46:10'),
(198, '80ed5a40-97a6-41eb-b21a-844effb4c726', 'aisyahmarsha\r\n', 'aisyahmarsha\r\n@alittihadiya.com', '$2y$12$4JpFmdd0nh8o/i4lFZUrzOxGJe/i3tU1sp.2PpRJF.dBp0BNALyIa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:10', '2023-12-27 07:46:10'),
(199, '2cb6e933-d38f-475f-9655-4055ccef7547', 'zikrieazhar', 'zikrieazhar@alittihadiya.com', '$2y$12$agNVEYYfoJSlB1tkxjPlSe04cc596yRXH7FgE.wMLKFH7.nEkKpcq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:10', '2023-12-27 07:46:10'),
(200, '56fc50ce-88ee-4925-9dc4-09823b0432e2', 'nafirasaqilah', 'nafirasaqilah@alittihadiya.com', '$2y$12$4JSaFGpfc/JEmuCDfd1iXe51qJ72jCr1MHBJruNy6y6YrIsNNvkY6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:11', '2023-12-27 07:46:11'),
(201, '7f215bd0-3ece-4264-a0ef-17a6c1273be1', 'eggymaulana\r\n', 'eggymaulana\r\n@alittihadiya.com', '$2y$12$Xdd3sMWyVtrbWP6ilM7F3OaRzkBhJ3sfnbriVCzYzEfH8g1TnoXDu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:11', '2023-12-27 07:46:11'),
(202, '2465fac2-48be-4140-94b0-94208e96c0eb', 'rafafauzan', 'rafafauzan@alittihadiya.com', '$2y$12$AlL2g7ykdHr.gCjpAQ.Yv.xdpx6x0p/nAQD2GrTX0nQLTDb8meulm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:11', '2023-12-27 07:46:11'),
(203, '41401e22-6026-4f82-8d88-41d253100a6c', 'azkaadhyasta', 'azkaadhyasta@alittihadiya.com', '$2y$12$dn8YlaLJnGnnhY0g42jxgex8m9JjYpSZQNsj59FMmD34PcfuhI6Iq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:12', '2023-12-27 07:46:12'),
(204, '87d23787-ce1e-436b-ad65-1494a15c9f2b', 'bilqiskanza', 'bilqiskanza@alittihadiya.com', '$2y$12$dERAsBEoOD1PUAEWiHqe4eWGSOAT36rHgHCIDARPvpaspRSDbYrnC', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:12', '2023-12-27 07:46:12'),
(205, '422f43e7-2605-442d-bfe7-304be1fb589b', 'nickoardinata\r\n', 'nickoardinata\r\n@alittihadiya.com', '$2y$12$2w9Q4sxS.U0k9AUpaUiGYObbIWxr7ClmSc2W7ZlPZi3vW2oBdOdcK', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:12', '2023-12-27 07:46:12'),
(206, '3fee26d3-10ba-4ff4-bd8d-9751e5649180', 'mhdalwi', 'mhdalwi@alittihadiya.com', '$2y$12$nJlhiYwPA.o5d9y88Tvc5OfeLxMKx/0QkbgRfbUmnIE81WhD6Zwf2', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:12', '2023-12-27 07:46:12'),
(207, '7b6586aa-2d3f-469b-b338-aea2639a7fa9', 'annafizsahqir', 'annafizsahqir@alittihadiya.com', '$2y$12$fbmOhT7GeTTuHRR.vCnKC.I6OsLQlD9e5BLezf8DsK8P3BT3qSr42', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:13', '2023-12-27 07:46:13'),
(208, '35f91acf-64c4-43e6-8b27-bda12fec7bf4', 'atikaazra', 'atikaazra@alittihadiya.com', '$2y$12$Z4RiufSCAZiWbqTAVindtOFiOKjq3tTyOdC7aGh/dEIp1TCMO64qK', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:13', '2023-12-27 07:46:13'),
(209, '261621ac-b4a2-4f74-a5e0-a177d5cbc2e6', 'nadiraandara', 'nadiraandara@alittihadiya.com', '$2y$12$6B60eLGL5pD1OynUbzJP6ueR1B0hpxBIcRjqqy4fqjAocK77UvJgi', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:13', '2023-12-27 07:46:13'),
(210, '6b63f0e6-c09b-4d05-a7a1-7164eabee64f', 'dwibulan', 'dwibulan@alittihadiya.com', '$2y$12$hyw.Y5ZNLPOwUkhVEQQh5Os9vmXrt5drMSXeKyvLqr8TzpAPC4YuC', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:13', '2023-12-27 07:46:13'),
(211, 'daa8ebac-d1f4-4549-a7f4-3fe5c30d6187', 'fernandonatalyo', 'fernandonatalyo@alittihadiya.com', '$2y$12$z.t1x/Dqk/Cen3T8l1Vv3OpDprC7rTPa3rIyjyRq.h2a1w9OmHsha', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:14', '2023-12-27 07:46:14');
INSERT INTO `users` (`id`, `uuid`, `username`, `email`, `password`, `email_verified_at`, `role`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
(212, '07e03a0d-7fe7-456c-9beb-4c61484d3d0b', 'muhammadel-buhari', 'muhammadel-buhari@alittihadiya.com', '$2y$12$9l6Gy1vunXXAbI/jyovC1u6U2ki.xcWh4sLnwuzuwv/8oCmZTL6wa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:14', '2023-12-27 07:46:14'),
(213, '6be75f2e-cc73-4b0c-81af-3a67cab64bf7', 'balqiszivana', 'balqiszivana@alittihadiya.com', '$2y$12$8UxKIWWqDU2N1klPnx/EZOOYeWTAIa/ud8i2xJAeXtB7Nub1hKzC6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:14', '2023-12-27 07:46:14'),
(214, '2bf55dd4-3458-4adb-a0da-be87bde55a99', 'nafisahmuharrami', 'nafisahmuharrami@alittihadiya.com', '$2y$12$FhKc9yt8NFohA.AV0LNmKOy3boVS.AoZMJ7CNjd3oSMmVtAo4rj0q', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:15', '2023-12-27 07:46:15'),
(215, 'af48378c-5588-4894-b895-50bcaf2a4dd9', 'deswasalsabila\r\n', 'deswasalsabila\r\n@alittihadiya.com', '$2y$12$l6Go84G6JDuDqU8gukityeMswQMmyJPX3J/SZLBTF.ksITzFeTkG6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:15', '2023-12-27 07:46:15'),
(216, '9d1e63ed-db2a-4348-abb8-0212fedec169', 'muhammadfauzi', 'muhammadfauzi@alittihadiya.com', '$2y$12$qiJeN.3ZxK1GRgP7kd5H.e7uyjzphv0D64vbkyoxvBVEcwSuno/0O', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:15', '2023-12-27 07:46:15'),
(217, '51a45dd2-cc5f-450a-9656-77046deb8ed1', 'ziraantanovia\r\n', 'ziraantanovia\r\n@alittihadiya.com', '$2y$12$GYqREy9.5rlqyl/qoJQZ5ehG6NECOosew6BzeVZIjbDElBtpZgH4C', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:15', '2023-12-27 07:46:15'),
(218, '4fedb291-dd24-43de-9e2c-c17a0284b9ae', 'nurulamelia', 'nurulamelia@alittihadiya.com', '$2y$12$PyY3KM3KgLK0vgGbuXa1Be.PjSkhsXRNn6qWeIp6HASUq0hsAbf0u', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:16', '2023-12-27 07:46:16'),
(219, 'ea183ae3-94dd-420f-b610-fdc00ab081b4', 'm.rizky', 'm.rizky@alittihadiya.com', '$2y$12$hitOViDHHxpoHuz2l1Q10.AMQ2h5BeNor8drecvgwf1xpXETEFoSG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:16', '2023-12-27 07:46:16'),
(220, 'a0b10d8a-959e-42dd-8f06-81c0f9e85353', 'm.rizki', 'm.rizki@alittihadiya.com', '$2y$12$A4/3z0UGMTKkmE3SsuQH6eMo75KDfJgyLzpWQqtQ/.sCGtgqPn2rC', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:16', '2023-12-27 07:46:16'),
(221, 'ed2a94dd-7e0f-4097-8e32-bbc5f1d76acd', 'miyanapuspita\r\n', 'miyanapuspita\r\n@alittihadiya.com', '$2y$12$64eA2poct.tPQAwvVXNhd.AFbo1jtaC6lTItajbVDsSQYn.VC2cdK', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:16', '2023-12-27 07:46:16'),
(222, 'd2fbd6c4-03c1-4852-9083-19c74604e11f', 'salsabilaazzahra\r\n', 'salsabilaazzahra\r\n@alittihadiya.com', '$2y$12$mHQ6HME/R1UguctQh5CMC.K6os35QfKE5XMz7AeXyBJ47iBZcrAHu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:17', '2023-12-27 07:46:17'),
(223, '2b19e428-a72a-44b3-8385-995b15935ede', 'rezkyprasetyo\r\n', 'rezkyprasetyo\r\n@alittihadiya.com', '$2y$12$Bm791kGUzaHe8j/7A2lMTuHOEmT2YDxi.OtQ/qt7ZjosAVjaxCCim', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:17', '2023-12-27 07:46:17'),
(224, '8f7aca67-9f7d-47cb-8aa5-042f1b28481a', 'rafaal', 'rafaal@alittihadiya.com', '$2y$12$Pb4qxYO1iBZmP0mql2WcGODwwIXBS.YYQSuErp2c5QsdJS.ruS4h2', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:17', '2023-12-27 07:46:17'),
(225, '66fd95a6-5463-4dd1-bdc4-11286bc2be0e', 'yogakurniawan', 'yogakurniawan@alittihadiya.com', '$2y$12$OGwQJicnux3GJufb/ywrMOtQE1pyf9jJiDD4LGsTH1DXLsaj3lJwC', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:18', '2023-12-27 07:46:18'),
(226, '8230da2a-7329-4e88-860c-db1b5d1847ac', 'khafiel', 'khafiel@alittihadiya.com', '$2y$12$IiDIk8W7SuR6qMwAGmBEQel7b6F/wROSsLeRjnA13iASchpORsvNm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:18', '2023-12-27 07:46:18'),
(227, 'e51cf699-18ab-4761-a739-f146ca20f114', 'yadi\r\n', 'yadi\r\n@alittihadiya.com', '$2y$12$BcqGGUAKaZ62Hy8kuggxVu8jQfzuxcmqhAohsjNCTyywwVF5MxO5S', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:18', '2023-12-27 07:46:18'),
(228, 'a203b053-c104-48c7-8919-bb60d31989ca', 'suryagemilang', 'suryagemilang@alittihadiya.com', '$2y$12$gDfzrneFI8oUHYu4ICFhWe62zkIlAaNdtKT5Xv16rXot0tspBCV72', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:18', '2023-12-27 07:46:18'),
(229, '3ed25902-3a33-492c-8346-57fe8314ff4b', 'aidilakbar', 'aidilakbar@alittihadiya.com', '$2y$12$VTUpotlfgmpJVL5p76YpCeZhsX0sbffwph1MdPvx3XOObKoq9pN5a', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:19', '2023-12-27 07:46:19'),
(230, '0800b660-6a32-4c89-b815-562afe92b346', 'fakhirasalwa', 'fakhirasalwa@alittihadiya.com', '$2y$12$76mU5tPt91CS4CqYsfpJ7uRhkH28JnikKh/.jGe2jyWUvzjFpk8x.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:19', '2023-12-27 07:46:19'),
(231, 'bd1acb0f-df26-4ce3-81e8-79cdaeb4cbe3', 'muhammadmanaf', 'muhammadmanaf@alittihadiya.com', '$2y$12$oxcUwf51ATevih4aX95s0urAsEvjjJw8PFrrZ5afCmKn2ZI5V6GPm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:19', '2023-12-27 07:46:19'),
(232, '36c1281f-cc6f-446f-a4f1-167b3ea4995f', 'renoal-farizi\r\n', 'renoal-farizi\r\n@alittihadiya.com', '$2y$12$4BsYNw.yX1qyMI4.H3r6OuSBEBqi2.me0LLwTscsPZGhJbTdeIIB6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:20', '2023-12-27 07:46:20'),
(233, 'd3efeb15-43e7-44ac-bd50-64b5488c94c4', 'gibranfabio', 'gibranfabio@alittihadiya.com', '$2y$12$KTA/NyjNkmKdaR.f5GVR5eFTw.pcI4Y3PZ4HqrIElsCPzAaKIlSH2', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:20', '2023-12-27 07:46:20'),
(234, '5c80edb9-057c-4a94-8326-29a5953bbb7c', 'alfathir', 'alfathir@alittihadiya.com', '$2y$12$xZ3iY8O9YI0w5R323oJBLedssKRTFB5Pv6zwmYZw9Y7j4lmwG.xpG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:20', '2023-12-27 07:46:20'),
(235, '7c7c0884-353e-406d-9277-0b0a75c662f1', 'mimifakhairunnisa\r\n', 'mimifakhairunnisa\r\n@alittihadiya.com', '$2y$12$.G6hnLS0tzd/w5MPOfxPseFKrmidMOd8yblkT1VLyHcBrEO.5Bgo.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:20', '2023-12-27 07:46:20'),
(236, 'c9cb47dc-779a-49c0-a518-b057ba69420f', 'andiniputri', 'andiniputri@alittihadiya.com', '$2y$12$rwAGq9oW95k4W6y8I6TOE.LhyOZxV3BonwvanG2rAOjp8fCAnfmE6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:21', '2023-12-27 07:46:21'),
(237, 'f218bf1b-5d9c-4209-9eb5-c779e559df38', 'ufairanur', 'ufairanur@alittihadiya.com', '$2y$12$5fZtHCvahqa9rXeP6tHfCuCeZQ2EXUEu64bHYPzp2zqhQicUt4SxO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:21', '2023-12-27 07:46:21'),
(238, '2be771fc-934c-43ca-b8d4-c00b5daf8eee', 'arjunaarya', 'arjunaarya@alittihadiya.com', '$2y$12$oxhQ4qB75yN.x7k0NYPL1eNg4Sk34YicwUo.sc7F/RWjXjoqfBcX.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:21', '2023-12-27 07:46:21'),
(239, '377661b6-1a81-4e7d-9b40-3c9243de7962', 'nayrasahbillah', 'nayrasahbillah@alittihadiya.com', '$2y$12$UD.w/sD40tko62EHmYqdD.MqjO4OxQgUsDl.slDq1uqx7sHixTx5q', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:21', '2023-12-27 07:46:21'),
(240, '6a93c619-463d-464e-a4cf-86851454251e', 'alikanaila', 'alikanaila@alittihadiya.com', '$2y$12$cPapeCgE29vjzGlOjOvc6eQ.CWdAZAhY9joyQoaUkeYXwIKoQ612C', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:22', '2023-12-27 07:46:22'),
(241, 'cd0dfcc2-4248-4b92-befd-513d0d7f4bba', 'khairilfahri\r\n', 'khairilfahri\r\n@alittihadiya.com', '$2y$12$giu3zh8J13oe7/41EuKyEuDMd4Hk3/owYUvAWBzVWfrep7IzuIKQu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:22', '2023-12-27 07:46:22'),
(242, '01cd8d0b-358e-4cef-8be7-4346a56905fa', 'nazihahmuharrami', 'nazihahmuharrami@alittihadiya.com', '$2y$12$Sp3OVDw6lZK6kk39GuV/suvqYgkCdDVfLpjV/GXLZuh0pAZiK35ku', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:22', '2023-12-27 07:46:22'),
(243, 'ba85ec73-c133-4ad3-80c4-7d82a68d14fb', 'mutiyazafira\r\n', 'mutiyazafira\r\n@alittihadiya.com', '$2y$12$3tGrKGEh.rCbxHu6kuCkN.omXV4SNUefikK1BUHmRZP/AoH4a/ZuS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:23', '2023-12-27 07:46:23'),
(244, '34cdadbc-a21c-4cf0-a922-48e4ecaaf0ea', 'azizahpuspitasari\r\n', 'azizahpuspitasari\r\n@alittihadiya.com', '$2y$12$NSVA7wFkrWAFcHYPzZ00yeT4ZxDabUPI3wwmFpFhp2BTeJtpsMvyK', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:23', '2023-12-27 07:46:23'),
(245, 'f2ce38ae-e483-4919-ae3e-ea5a578ac356', 'alfaaditya\r\n', 'alfaaditya\r\n@alittihadiya.com', '$2y$12$jvK91RvlQxmpYt.qhAmQj.wludmqPCmaqW50RFV6jEaIylXqeBrh.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:23', '2023-12-27 07:46:23'),
(246, '5a8accdf-4dc1-4f6b-b276-5ac65d60100a', 'agungprawira\r\n', 'agungprawira\r\n@alittihadiya.com', '$2y$12$qcIQEwll9Yp087EUh4/AAe5W/RXKHhWI3TdS6f6gurbsjAs3X8vS.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:24', '2023-12-27 07:46:24'),
(247, '079328c8-afa7-499f-99f2-f85e0b55e6c7', 'sitihumairah\r\n', 'sitihumairah\r\n@alittihadiya.com', '$2y$12$9U3CxsvQyUBeOfNeuA57E.WhNlaqrLO3ICIXvV4qiBvAJ280PuZdC', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:24', '2023-12-27 07:46:24'),
(248, '257c9c99-ddb1-4c4f-abe8-f370ab397dfe', 'hasbyrahman', 'hasbyrahman@alittihadiya.com', '$2y$12$Ge961HmVjlxSgOmLjktpQ.PSzOoOiIugFZTrjfBY8rUkao4Gft/Ku', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:24', '2023-12-27 07:46:24'),
(249, '1689b3a8-2253-40e9-91eb-19706f7653d0', 'duwijulianti', 'duwijulianti@alittihadiya.com', '$2y$12$y25raeocYwfP/n/WkZly3Olw8JcH3qwvKnrU4VIN/S5fQDA7jUbaS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:24', '2023-12-27 07:46:24'),
(250, '124038ff-711f-47b6-bac9-17a02bb20986', 'alnadhif', 'alnadhif@alittihadiya.com', '$2y$12$bnPvFcTgfqEQvJHWnrvuQOyP9Qfg2RLnNFW7S86Od4.3PkpL6guSC', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:25', '2023-12-27 07:46:25'),
(251, '7190af4e-b67e-4bba-bd0f-9951c262025f', 'm.alcantara', 'm.alcantara@alittihadiya.com', '$2y$12$WMaBrPUnKSBdOpTCTW6fHe9U/CWDoKv2dDIRSQXR15iW194RooDIG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:25', '2023-12-27 07:46:25'),
(252, 'f65f87f0-75b7-441f-8f4d-911a5e860869', 'putrithalita', 'putrithalita@alittihadiya.com', '$2y$12$R./qprF5ylQIdUVzLaIuTux.DHUdWey5rkKojstPFBvLnQFmsVTyW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:25', '2023-12-27 07:46:25'),
(253, 'e64cbd8c-58d4-4be3-aad0-bd90e3779a48', 'm.aziz', 'm.aziz@alittihadiya.com', '$2y$12$W4SEqgLLO3eHsecYllfF2uGhHlKrEheEJWxJXopxT7NcyQMhE4i5q', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:26', '2023-12-27 07:46:26'),
(254, '44544658-3ca7-4c78-ba92-a6be18bfaa5a', 'chilamikayla', 'chilamikayla@alittihadiya.com', '$2y$12$1kqEjx2FATAefkIog4cqS.jQp/pznVKyTfj32QaOPgAjABI16n0Nu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:26', '2023-12-27 07:46:26'),
(255, '5f70ea9b-596e-4f2a-9396-a7d69362e148', 'radityapratama\r\n', 'radityapratama\r\n@alittihadiya.com', '$2y$12$Hx5tIsJOMIwGziRKkx3UB.zU4THMhLohYWW8I7y7vV8sX3XSTEQsS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:26', '2023-12-27 07:46:26'),
(256, '406ac426-d690-4949-9fcd-e4742d83409e', 'daffapranaja', 'daffapranaja@alittihadiya.com', '$2y$12$CQ9ZCsj3F8J/TwP0FE5xuePXQm.qGRM82liG4vSNcfBcxbXmeMn3a', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:26', '2023-12-27 07:46:26'),
(257, 'ede175b3-9326-42be-82dc-3dbe29dcc6f2', 'adeliaputri', 'adeliaputri@alittihadiya.com', '$2y$12$ju6oiXl6yh5jro/f0f4gXeP5gk5n6M2H1/RUzdtlwT6tDN.sC2y3y', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:27', '2023-12-27 07:46:27'),
(258, 'a825de7a-c1c4-4ad7-b0ee-fac2876d302d', 'alrizky', 'alrizky@alittihadiya.com', '$2y$12$Vvf848dTffHO1.MhfnJwJet5d1dDLESZ2Tbx6uQD5LTBx6zmQMPOC', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:27', '2023-12-27 07:46:27'),
(259, 'e73cebb8-1a28-445b-a21c-e7148fd98200', 'raisyarahma', 'raisyarahma@alittihadiya.com', '$2y$12$6FwO/mpZKxLvOolIZxoqWu2WTXAu5vJRKLkSu4pvN/i9Q6Q0JpoDy', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:27', '2023-12-27 07:46:27'),
(260, 'd63ab47b-2b0d-44b8-b75d-e302c6e61327', 'nadiaazzahra\r\n', 'nadiaazzahra\r\n@alittihadiya.com', '$2y$12$gAa2EBtICh9m6oZIiHAMYOl3i63R3Z96h/HRFGS49prXGcPBLBr3C', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:27', '2023-12-27 07:46:27'),
(261, '989973ba-95d6-4432-9532-7dbd46d0d8d2', 'khairasyahfitri\r\n', 'khairasyahfitri\r\n@alittihadiya.com', '$2y$12$5MDYhc5iO0rY4dcNkN6Nv.cZ1/FPRXwWRkskqPtAvuW3p3sKHpEh6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:28', '2023-12-27 07:46:28'),
(262, 'bd8d60c1-72c7-4364-81df-0131d3683916', 'raffidary', 'raffidary@alittihadiya.com', '$2y$12$njxIKNcH6.WWeWxK1/pZ/eh1vFMLNMU5oRqK.Xt/HfEI0PhVtRrF.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:28', '2023-12-27 07:46:28'),
(263, '3f07cbe6-f444-4a29-bc80-137f756bc096', 'annaurayasmine\r\n', 'annaurayasmine\r\n@alittihadiya.com', '$2y$12$DJtrt9FyeR0Hz1HJZDk8deHGrk/mSPCCm57XG6Yen2dU.UdY62/P2', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:28', '2023-12-27 07:46:28'),
(264, 'b02d2b5a-81d6-454e-8e69-b060cf6b0ef6', 'febriansyahputra\r\n', 'febriansyahputra\r\n@alittihadiya.com', '$2y$12$4f2yPNhgYT23B08Lg6XP7OljZXAc9XDKHIg8717IKoxG58nSveZ1G', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:29', '2023-12-27 07:46:29'),
(265, '9333af14-3e1a-4a9d-ab93-5ac0ae2b3e94', 'muhammadrayhan', 'muhammadrayhan@alittihadiya.com', '$2y$12$o5/JTdCDTHSBYcLDbrIksujawRJbyJjiBFGP1PPo11SkFPxAf2BvS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:29', '2023-12-27 07:46:29'),
(266, 'b96e4649-1427-49c0-b0de-811a8fa9f380', 'ihsanakmal', 'ihsanakmal@alittihadiya.com', '$2y$12$MLOSmLnrnaTcIWvQLCsYg.ExlCmN12lrbBZoAewLDM/7WK4OpSEKi', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:29', '2023-12-27 07:46:29'),
(267, '667e2584-1c4e-4efb-a2a6-540226e71243', 'desyrahma', 'desyrahma@alittihadiya.com', '$2y$12$VJT4DVd0bY/fYA9C69x.k.PsYMHW/NWLZgSRB4HoyCoWW0VK1rWvu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:30', '2023-12-27 07:46:30'),
(268, 'c5460b44-dff0-488c-a1bd-b105bf1855dc', 'muhammadsatria', 'muhammadsatria@alittihadiya.com', '$2y$12$IWUpXdDGsr522qVRnSnYJe0Kxnmf9wsmYeVc5mBZz8dTUPR.g7rW6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:30', '2023-12-27 07:46:30'),
(269, '403de046-4769-4a69-9f67-a5ccb184c4a9', 'cleopatrarensy', 'cleopatrarensy@alittihadiya.com', '$2y$12$iPUar.xZTcCu7l57KcirdOH/a0BFstcni1tCb9B6YN1d1eCPa2LW6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:30', '2023-12-27 07:46:30'),
(270, '69d76307-fdcd-43a9-9865-716ace8e5f34', 'denispratama', 'denispratama@alittihadiya.com', '$2y$12$uRakjZRlfqts84f.ZES6/uqh0.QRmvA86AWoCiZCc2zG65YmH3aYK', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:30', '2023-12-27 07:46:30'),
(271, 'e948c43e-a685-4488-93cd-20d7749d2455', 'dafa', 'dafa@alittihadiya.com', '$2y$12$dLFO6iI3IHd8kUdc8CtGJeGCty3Nbg4B8OKrteK2PaMX7UBvhZ.w2', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:31', '2023-12-27 07:46:31'),
(272, 'a0a3a635-3990-4c6b-abdc-5435aff7cb34', 'febiyana', 'febiyana@alittihadiya.com', '$2y$12$ZgIZfAxXUQprFDHYW3hOmePiEUqxDCatt6TMAAY7s6hdUk5WmDY2S', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:31', '2023-12-27 07:46:31'),
(273, '472bcfaa-9c42-4b12-b7e1-3bbc7efcdafc', 'hafizaal-malika\r\n', 'hafizaal-malika\r\n@alittihadiya.com', '$2y$12$eA8pNoLSciOAy.rM7SdmXOLN1NVkmrUYsheEdV7f5hXKyincGjTEm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:31', '2023-12-27 07:46:31'),
(274, 'e58a7aa9-3324-4907-9b17-6170b8e9c570', 'alfiandra', 'alfiandra@alittihadiya.com', '$2y$12$yhDIkLPnMN34aqcjDQs8Bel/KIrfilNRqGjKqSk8Ak3.Sd99Qmgxq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:32', '2023-12-27 07:46:32'),
(275, '20d7138d-2a01-40c9-89d8-6b6a8aeda8ea', 'nurulputri', 'nurulputri@alittihadiya.com', '$2y$12$NuW9dp9Y0Z0aKRUgcbj6I.6YoQgkSkptc7e6kbBm0UxN4R9XiyOky', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:32', '2023-12-27 07:46:32'),
(276, 'e6d0c7e6-9a45-4fbf-9f31-659f6334a6ad', 'dolial-hafiz', 'dolial-hafiz@alittihadiya.com', '$2y$12$8vnqQ4MyEcbi08Sok9Z2R.wBcVzTQrYS2xNlxK14WoXedYCKLeM8W', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:32', '2023-12-27 07:46:32'),
(277, '55302d5f-689b-4a46-92e1-66dc0925b268', 'vinoraditya', 'vinoraditya@alittihadiya.com', '$2y$12$J8wPJhGOuuTpB2ILJRuVx.iXBQ.8ULa/w9vEK9Fx9hgAxghTtsbHW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:32', '2023-12-27 07:46:32'),
(278, '5805e55e-ffbf-4cac-875f-caf0f3b99159', 'salsabila', 'salsabila@alittihadiya.com', '$2y$12$O8BBSwfie6iXU7kz60STceFhomJDMmbLYWnrNjkmmNGdxXPUpF6hK', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:33', '2023-12-27 07:46:33'),
(279, 'c1c35396-6b81-4b4a-a901-a8326596a8ab', 'imamali', 'imamali@alittihadiya.com', '$2y$12$ao67Kq3yEqCRAGQ3bh.CoeH6gc60LimZxyLHyPCQvFuIlE2p2l8ey', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:33', '2023-12-27 07:46:33'),
(280, '1d28c8ef-0b37-4fbe-996a-210fdddd9acd', 'm.alfazan\r\n', 'm.alfazan\r\n@alittihadiya.com', '$2y$12$HgOSYoZfWM1mkda3RnKeJuglMyJPLnI8v2W264XRnwZQEEIzL3PXe', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:33', '2023-12-27 07:46:33'),
(281, '487ef1b3-cb03-4ced-8c57-aabf835d8688', 'hafizahkhayyirah', 'hafizahkhayyirah@alittihadiya.com', '$2y$12$kFv2AMp1DcHTzEbPwy33SeksNaCe3Vl35qtPWH5SDLkzRwbAkgs4e', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:34', '2023-12-27 07:46:34'),
(282, '731a61b2-87bc-436e-acf1-10f8d7c780b2', 'aisyahkoriah', 'aisyahkoriah@alittihadiya.com', '$2y$12$kaafLwzpeaChBZ8mWF6QX.727yW6QY7bhlzqGLaqmqFT6h/XwS9k6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:34', '2023-12-27 07:46:34'),
(283, '7a3a26cf-b216-4268-8270-fcacac27f84f', 'arkasyafatir', 'arkasyafatir@alittihadiya.com', '$2y$12$Wk02SSJDBS68TQI3x5CKeu6T0LSUyFP.dTAkn6AjH9rILhy63porm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:34', '2023-12-27 07:46:34'),
(284, '12564760-00f6-452b-a16b-a43ed3b2df2f', 'virzaandara', 'virzaandara@alittihadiya.com', '$2y$12$85MgEg.0RdMV5.Pu1ppmA.hS/GzRrxo4L1mZwEiSHcaT/Au51RyFW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:34', '2023-12-27 07:46:34'),
(285, '6470c4af-9800-418f-b12d-7083f78d9c96', 'raniaputri\r\n', 'raniaputri\r\n@alittihadiya.com', '$2y$12$Q4Qm1diOjIJbgLADD7P83OP7ncwUoMgO.Q6ldNJ0Z0HJCwwQxjYaO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:35', '2023-12-27 07:46:35'),
(286, '791457ed-a1cc-4631-947d-3798a6deda23', 'ezairawan', 'ezairawan@alittihadiya.com', '$2y$12$E3mq/VVvgyWVntIH53JP3eJ7l5D4yPiqigJcO5ChaTVIedW9cFofq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:35', '2023-12-27 07:46:35'),
(287, '96c49e11-7223-4577-9ee2-14943fa0b9ec', 'keylasaputri\r\n', 'keylasaputri\r\n@alittihadiya.com', '$2y$12$Tlt4zVJoV.T/TOw2ZoobYuT8MLCtBa9iOQud8oIdKRsSOvw5ECHWm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:35', '2023-12-27 07:46:35'),
(288, '1c557976-0b3a-4511-9b20-b785c6756a26', 'nazwakhairani', 'nazwakhairani@alittihadiya.com', '$2y$12$D.vmfj2A4t1ZhUD/TXxdX.I7qx.3inMfA7j2QCt22kKIUQ7HnVkEu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:35', '2023-12-27 07:46:35'),
(289, 'ad556065-7a44-4680-8381-6e3e28b60f0f', 'akilasahira', 'akilasahira@alittihadiya.com', '$2y$12$AM6JWUQ5pAxwQV1bz1kjPeDUZkcr8FKB.PPkiTOR0ablLjcUMqVXa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:36', '2023-12-27 07:46:36'),
(290, '94281010-cb45-4860-8d39-2a853016a20e', 'nuriarahmah\r\n', 'nuriarahmah\r\n@alittihadiya.com', '$2y$12$lYTk/9fN6IyVEZ7HBL9vaOZ90tmLOpymHd.PJKwsDbo31d/FJxYgW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:36', '2023-12-27 07:46:36'),
(291, '9294754b-f387-4309-a799-d200c3f46119', 'muhammadfariz', 'muhammadfariz@alittihadiya.com', '$2y$12$hluEMSnxr3SZC1Ib3DfC4uPFVQEfKf9coqroi2Gd7SKyYggaL/hhC', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:36', '2023-12-27 07:46:36'),
(292, '56ebc906-18e3-423c-87e7-da8a9b19f701', 'nazwarahmadina', 'nazwarahmadina@alittihadiya.com', '$2y$12$f33S0ztmNTUqU7fgyCxLZOoxIvU67RB.WK0Hrqe0gM5TayOL.kpwO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:37', '2023-12-27 07:46:37'),
(293, 'edd80314-55c4-453a-a570-a038e556a241', 'naurabalqis', 'naurabalqis@alittihadiya.com', '$2y$12$cXB9ySH/r.9Z1baS86wQZuGynI.rbO4ZwKDu4hhn4TD.lpzMjqOMO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:37', '2023-12-27 07:46:37'),
(294, 'e861080d-f9ba-4cc8-86e5-fa33c3ddaf59', 'juanrodis', 'juanrodis@alittihadiya.com', '$2y$12$BEXnjr6eW4IVPjnZ5vK0iOvsyv4CGgqAH3M0qVDekKxl9fnOzoE5G', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:37', '2023-12-27 07:46:37'),
(295, '9f85ebe7-b8ec-4aba-b0d2-3b7f28de1192', 'syauqiramadhan', 'syauqiramadhan@alittihadiya.com', '$2y$12$mj.5iCf/WrZgmtS2ZAVUyei68tOVJSlwQGZxnNyvquO5Qbh1nSJPS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:37', '2023-12-27 07:46:37'),
(296, '1942120c-614d-4787-ac41-5709257f0099', 'asyifayuwandira', 'asyifayuwandira@alittihadiya.com', '$2y$12$EC4qwwUfTDe75qXNbUKHDOKvU4yetMqCvM4Oo7oyaU1l1Xska4rqy', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:38', '2023-12-27 07:46:38'),
(297, '42b83863-ed0f-46b1-ab03-25f0344e8290', 'dedekaldiansyah', 'dedekaldiansyah@alittihadiya.com', '$2y$12$35CSnzfa8NAhSaMRBmzIuOoSfdc/QajY8890oz.yeM5U3qtKhCj9y', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:38', '2023-12-27 07:46:38'),
(298, '7c164abd-a7ca-468d-aa74-e9cea9e2a688', 'raisasyahputri', 'raisasyahputri@alittihadiya.com', '$2y$12$7wMtKc/N70wsPijT1oOrbO/F2A8ziWNT1FhsHfU3l0f2Yo4F.uQVG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:38', '2023-12-27 07:46:38'),
(299, 'aec51d4f-8945-4dd0-98bf-d43468c33cbe', 'rizkydwi', 'rizkydwi@alittihadiya.com', '$2y$12$BiPwjFDy2cRgzNRGSr8Do.Awuft3gJ8XbGvFH07ED.j3sWYvEeODS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:39', '2023-12-27 07:46:39'),
(300, 'f304899b-4419-4918-a5e6-5d026d44709a', 'andinisafitri', 'andinisafitri@alittihadiya.com', '$2y$12$46EjPLXkHNv5XTqsU6Od0.JDnH.SJNCJvHZiWLf8uhxrjcidQgWcq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:39', '2023-12-27 07:46:39'),
(301, '12a5d0a7-640f-4992-8b9a-272d592576d4', 'dindakirana', 'dindakirana@alittihadiya.com', '$2y$12$SuWOheIvBaSERI03874rH.L.w3vVEKdGDn5KqVcEqp4onwOZ/pmqu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:39', '2023-12-27 07:46:39'),
(302, '97d1aacd-7653-4b7f-8376-2b3e1acfa9cd', 'muhammaddzaki', 'muhammaddzaki@alittihadiya.com', '$2y$12$VCV8lVQi/ZLcroSAvYfeCu8rgx43TacIwe8JAHmGOfL0.jfpdTZYy', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:39', '2023-12-27 07:46:39'),
(303, '2d698a5c-c9f4-43fa-a322-8bc9a5fc0367', 'muhammadrama', 'muhammadrama@alittihadiya.com', '$2y$12$37f3n31uet96Hlhvm/fdg.orhazAg6JZiXcXWJ3VJyfzeIwLYOlya', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:40', '2023-12-27 07:46:40'),
(304, 'a8f2698e-6233-426f-be0f-20e383708c08', 'dwimeilany\r\n', 'dwimeilany\r\n@alittihadiya.com', '$2y$12$IMtLmdaOT/YX9rl8.VbySeL1sqHrnlz5sLwCAY0jXbd2Dbq8ffkHO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:40', '2023-12-27 07:46:40'),
(305, '085202d7-95aa-495a-95a3-4cca90fa6d54', 'gistakhairani\r\n', 'gistakhairani\r\n@alittihadiya.com', '$2y$12$8cX6O3BR2GA3WSyDMX6QruoEA96fGTRHmTrZ2ePHJFHjiIk3Y08H.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:40', '2023-12-27 07:46:40'),
(306, '79f125af-1752-4f9a-9e18-dd2ba3e533ef', 'enjelipurnama', 'enjelipurnama@alittihadiya.com', '$2y$12$0/09HY7ILr4QzZVaF6Bn2O.b.EdfAVJ6MVVxIEDB0jiQQjcKBsrZa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:40', '2023-12-27 07:46:40'),
(307, 'a33b3378-3266-4afe-9d91-12fc5e84cc26', 'bebypertiwi\r\n', 'bebypertiwi\r\n@alittihadiya.com', '$2y$12$OwhoYcduH02ZgfrwW7H7.eRh0N/UEbdQSinctv6KGvx2qA69e3u4q', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:41', '2023-12-27 07:46:41'),
(308, '6b157ee4-d3e6-4089-9a40-7bf46ee57b48', 'andhikaiskandar', 'andhikaiskandar@alittihadiya.com', '$2y$12$AtWDcmKRPkE/0csDN9OqpeDwlkj6H7WKEerBc5Cv8CJflNq1Lx5dG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:41', '2023-12-27 07:46:41'),
(309, '76ed67a1-bcd0-431a-880a-5e4599539d2b', 'haafidzahaznii', 'haafidzahaznii@alittihadiya.com', '$2y$12$b68uC3/QbGs6xist1VaU3ubtubzAkCs1o9a3ibkDImgDZ2/TDOTPa', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:41', '2023-12-27 07:46:41'),
(310, '4f37db7c-07c4-46ef-ad4c-58b37665b2b8', 'alfazar', 'alfazar@alittihadiya.com', '$2y$12$zDCYEftYeEql1thUaHMZXOrmPrXzqaVvktdTsxI4j1ptd76j6HSr6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:42', '2023-12-27 07:46:42'),
(311, '31a1f7cc-f506-4f87-96ab-6e06023b62e2', 'mikaylaaziya', 'mikaylaaziya@alittihadiya.com', '$2y$12$eJJPIuHAu2klVikqXUq6VeiowHYz7LlUZvEyxJBwPI3yy6oDEXgV6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:42', '2023-12-27 07:46:42'),
(312, '3016d1a3-b009-4ce1-9215-d9e23d6ec22e', 'aqilabalqis', 'aqilabalqis@alittihadiya.com', '$2y$12$67vVuY3xNRpBCCDXxpZpeugBF/HFRYGFyFdp31GQixqV1NkMGg5R6', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:42', '2023-12-27 07:46:42'),
(313, 'ea24d53f-89d5-498c-b059-7ab57505a487', 'azkaazfar', 'azkaazfar@alittihadiya.com', '$2y$12$EWYGqh2ZUHLUqix73rs3JeNS/A3u5zpjRRKIPgwHMMBYLvuLyKUi.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:42', '2023-12-27 07:46:42'),
(314, '85b69d4b-175e-4e9b-80e6-5f68bec03919', 'auliaramadani\r\n', 'auliaramadani\r\n@alittihadiya.com', '$2y$12$CI4QcoMTVKX0LzwYkqWe.eWSsJmiSftYS.qs.sboUbDoVWekHBdDS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:43', '2023-12-27 07:46:43'),
(315, '171630d4-e0ab-4246-8bde-b7a784bd53f4', 'm.raffa', 'm.raffa@alittihadiya.com', '$2y$12$SGw9sq.1RQheCoc0cfXTzeDa5EgzL8lmZUhCsnodBmLhJCjkZFEEu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:43', '2023-12-27 07:46:43'),
(316, '2247242a-7f18-40c7-bf9e-c0e61a5b2286', 'm.malikal', 'm.malikal@alittihadiya.com', '$2y$12$vivxorHfnQSbfY4df7uLhuZc8UnCUml.LcPBF0iIFXDUuuobMaChS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:43', '2023-12-27 07:46:43'),
(317, 'a987e1df-73ca-4906-9592-4615611c8859', 'novalfebryansyah\r\n', 'novalfebryansyah\r\n@alittihadiya.com', '$2y$12$6PH1AnpNa2gR3UpTOeA6OO/1EpQXL6gnoZ12kWTNSCgi32Um65KtS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:43', '2023-12-27 07:46:43'),
(318, '7c5b01db-8d3d-402f-828c-6309d045fbe7', 'hafizhardiansyah', 'hafizhardiansyah@alittihadiya.com', '$2y$12$0nGe8uaXHnii6ogAc1PoGeclI6yY5PcMowze.BUS3bCpmONwC2EsW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:44', '2023-12-27 07:46:44'),
(319, '7a5b6a94-1ebc-4cdc-8e80-c2c1071a5589', 'abdurrahim', 'abdurrahim@alittihadiya.com', '$2y$12$ISAnAHcWmY8GlJxkRWvg3OXGh/TSdJoZ98AFjBzDPD9.H7L8ISRwy', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:44', '2023-12-27 07:46:44'),
(320, 'ce4297cf-ef36-4019-abd5-378efb498645', 'reyfanadia', 'reyfanadia@alittihadiya.com', '$2y$12$yf8UQdaFi5pbA3kbthL71u1JMp3meLz7UUOKBHXRygpRYOcLn3U52', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:44', '2023-12-27 07:46:44'),
(321, 'ed2f7731-8d14-4ef9-9cc3-86ee7717aa32', 'jihanamelia', 'jihanamelia@alittihadiya.com', '$2y$12$I58sG0QCq4PXJBa9B5J0rez68R5VtB6aOjwk8l4blI2N9ocIyOSKG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:45', '2023-12-27 07:46:45'),
(322, '8f6fdadd-d860-4588-80c7-92b8b431a7c8', 'anindyaalesha', 'anindyaalesha@alittihadiya.com', '$2y$12$ig0u0lKHkZwVJBMyLJNeMua1CJKIjx36.XEuE6MX0b3oXFmwQ41ra', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:45', '2023-12-27 07:46:45'),
(323, '3f640fea-70ca-4e13-9ee2-b94590975b85', 'mutiara', 'mutiara@alittihadiya.com', '$2y$12$Zrsd9DiexGXzjY8anSVwcOK/T5RXhR/0DDP7qVfdpL5/b5UeJu31K', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:45', '2023-12-27 07:46:45'),
(324, '0a4d1e0d-187c-4ca7-bb0b-e4436f0b3ebc', 'rafaniputri', 'rafaniputri@alittihadiya.com', '$2y$12$I8f2cAaVGgl37TXqe.mQ8.d6oT2opRAHTx.ugPoPd6becnnb4m7qW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:45', '2023-12-27 07:46:45'),
(325, '8ca1cc91-66f4-4578-b82f-c0b215815f17', 'abdilrasya', 'abdilrasya@alittihadiya.com', '$2y$12$HGTo9Ouj3rISYgxm6e9ZMe4I/dYHWUldJ9Tq9DxDVBrdsqedd.U5e', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:46', '2023-12-27 07:46:46'),
(326, 'bc0eba1a-1771-4382-b9e7-74ed27ae8931', 'rafiadithya', 'rafiadithya@alittihadiya.com', '$2y$12$5YRw.wMoVJ/wRlpKoTd.W.G1jB/6pCmTcG4.i2GUF/mHcf5t8urh.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:46', '2023-12-27 07:46:46'),
(327, '1abc8f1a-c9f3-4523-9249-3bc76e758ed1', 'silapirlia', 'silapirlia@alittihadiya.com', '$2y$12$BEcg4BtpRN9/fUp1Bjvme.cIyTsAcKu1JQgPFL89MRJ6WB5.tJjmu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:46', '2023-12-27 07:46:46'),
(328, '22d2e76c-5b45-4642-9b55-8e77a8243911', 'alpandy', 'alpandy@alittihadiya.com', '$2y$12$7dDUebUkTeJtBEboXc59Lel8d5ZB4pL2VY8W4nS/nrX652513bneu', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:47', '2023-12-27 07:46:47'),
(329, '9956f595-cf5a-451f-87ea-774fa5d0aad6', 'arsyahrama', 'arsyahrama@alittihadiya.com', '$2y$12$5uUi.zQU0y/IUtUGA6ugJ.ry/GcyIrCdQ9k7JLjFNIWPrnJl/mlhy', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:47', '2023-12-27 07:46:47'),
(330, 'b1f5766d-29a2-463c-8004-e2711393ecf3', 'hildansoleh', 'hildansoleh@alittihadiya.com', '$2y$12$DfRfu9/rcsjzFdjgBmqybOkM0/YrrZwqhiOxzFwW8hM8E1D074eD.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:47', '2023-12-27 07:46:47'),
(331, '21072216-4734-4bdc-862c-f6d1ff4ba9bb', 'bungaranjani', 'bungaranjani@alittihadiya.com', '$2y$12$XUBeK8e7skq0/ou0xE9YIeDKXrmAmLno/RcaRuN0S9FBhlr4mMkV.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:47', '2023-12-27 07:46:47'),
(332, '2dd11ec8-0988-48bb-8cfd-6f8aa492cee2', 'aqillaal', 'aqillaal@alittihadiya.com', '$2y$12$NiGS8GCM8Sny/fb826R0cuXLMUnirLomaN0/P1aGSROfd2/V4xmHm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:48', '2023-12-27 07:46:48'),
(333, '626d1fef-aabf-447a-a5dc-6e68ae24178c', 'kanasyaayu', 'kanasyaayu@alittihadiya.com', '$2y$12$LQ7Haia10r037ImBHJng5uhyY0PTZm77Q2t52htBTQrC2QJb/Vs7.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:48', '2023-12-27 07:46:48'),
(334, 'f46a2a07-82b2-4cbe-b2be-0acc033daf53', 'fadhlikurniawan', 'fadhlikurniawan@alittihadiya.com', '$2y$12$nfiV/AsUVSurmmWJ.PvdIeFZg0na4/Y2Hswsq6g/Z925ZJMaXO2D.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:48', '2023-12-27 07:46:48'),
(335, '0b409434-a2de-4327-8a18-14bb636d4913', 'mhd.rizky', 'mhd.rizky@alittihadiya.com', '$2y$12$dYF2uK02NJ7j9JV7vQa2Be3VMYVsEIOpGLwORuzNYARO18UWNJzxO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:48', '2023-12-27 07:46:48'),
(336, '1a94c3e8-dc82-476e-8655-a1a1ded8b143', 'zulfanazhar', 'zulfanazhar@alittihadiya.com', '$2y$12$o7vbl8Sp1nc0/LAqtClmsu9XNoF5zBBQs3fgIW1oRoeyvuGXim5By', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:49', '2023-12-27 07:46:49'),
(337, '1bf42985-5ce1-40c7-a5f1-f23d2bc2a797', 'aurelnatasya', 'aurelnatasya@alittihadiya.com', '$2y$12$Gy1b.WkpX.svkUkHo7axXuNgeGpA853zxKG80dutgeIZcVFwmMTnS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:49', '2023-12-27 07:46:49'),
(338, '5a1ab053-2cbc-42dd-b78b-a8c5d3f0f3d3', 'mikaylarastya', 'mikaylarastya@alittihadiya.com', '$2y$12$x43IwIkfEUAh59mzYfnfoeCQLdgFVMV71QbZf9hzWsAHH4WLnUtcW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:49', '2023-12-27 07:46:49'),
(339, 'd85e78b8-ff30-4814-bd5a-5daa33438425', 'mhd.isa', 'mhd.isa@alittihadiya.com', '$2y$12$rrBFO7xAv7ES9yrSyVpiVe0ZiQK9wZgnpQk46LjXif5FxuV9xcPD2', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:50', '2023-12-27 07:46:50'),
(340, '4176bc02-c11e-43da-a9a9-37ff10e334d0', 'abqarirunako', 'abqarirunako@alittihadiya.com', '$2y$12$.XTsCHB6peuXn2UtKDkk0ei9osyBdFREhpZ0dOhkLVw/6E/vSM5P.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:50', '2023-12-27 07:46:50'),
(341, '83614dfd-4f20-4098-b35d-218ac3b43bb4', 'uswatunhasana', 'uswatunhasana@alittihadiya.com', '$2y$12$JAPRmpCrF4EQilUFZNKHFumQj6tvaztS/nO6MfhNgEhKKwfkLr/D.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:50', '2023-12-27 07:46:50'),
(342, '4424710b-7406-4b44-be8e-77a5cbc88e77', 'annisasri', 'annisasri@alittihadiya.com', '$2y$12$HaFhRoDLtSWBiL5BD81FV.zz0a0bgyKDUacEAjaqf4HXIL.R0xGXO', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:50', '2023-12-27 07:46:50'),
(343, '707aa770-6ccc-4fd9-a493-7a340c13fb6f', 'syahillaaz', 'syahillaaz@alittihadiya.com', '$2y$12$SgqvvBFJTF15fl.al1nB9exnI67o/L82Bb5.BPR1qZH0bfLt.DI/G', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:51', '2023-12-27 07:46:51'),
(344, '10858538-c6e9-42f7-a5e1-8e56eff239fc', 'januarrevaldi', 'januarrevaldi@alittihadiya.com', '$2y$12$6CDKqswq7YvccA7kTNKUP.x.v3/OmeGObzCtHC1tTXfyfI5y3Lzo.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:51', '2023-12-27 07:46:51'),
(345, '77ba1d7e-91a8-496d-8d01-c2752ecab6d3', 'rifkaramadani', 'rifkaramadani@alittihadiya.com', '$2y$12$tBcXAA49TZ0yAMYp1Mwu5.JBAwV5mUMtNEpKX3S.KC1ywDn380MeW', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:51', '2023-12-27 07:46:51'),
(346, '597dfe55-93db-4661-a933-118725b45b52', 'keysazahra', 'keysazahra@alittihadiya.com', '$2y$12$8/kV3eFZaDqvN13DSgrbretqoxsis4E6oI3HfPZIuLzTLx4kbi/MS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:51', '2023-12-27 07:46:51'),
(347, '430ba09e-fbfb-43b0-80c0-26d5b5193c3b', 'diwaramdahan', 'diwaramdahan@alittihadiya.com', '$2y$12$WF7BZwXQxOHQMJ8RMZZTE.VmJQ5fCcQI5ipqYEk/UTWRIzqKLzJzm', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:52', '2023-12-27 07:46:52'),
(348, '6b097f6a-0619-4840-9323-afcfbc8ca68f', 'muhammadalif', 'muhammadalif@alittihadiya.com', '$2y$12$/OySnuSDu2YopN2.wwD3g.hRSQZmH17peS0Rcj/QuMvtWplpw/ufq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:52', '2023-12-27 07:46:52'),
(349, 'dece579b-1ef0-42bf-9881-22d9e32fe0ab', 'abrisyam', 'abrisyam@alittihadiya.com', '$2y$12$lPXtdaBF2bjWm/6zUm/O6uv15hmmLxVr7.ZNMjRiiYie84OnYV7fG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:52', '2023-12-27 07:46:52'),
(350, '9e826739-144e-456a-83c5-7afa64bb7bbd', 'arinkajhui', 'arinkajhui@alittihadiya.com', '$2y$12$YeaLgcl8LctPYhp2Wv3Xae16zskPGvjURFZS0Tsth87AWW37LPZJ.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:53', '2023-12-27 07:46:53'),
(351, '07550566-d6ec-467b-afa0-e00847138a4a', 'akilafirzanah', 'akilafirzanah@alittihadiya.com', '$2y$12$2l3j2UMjiYBoqYdlWdG25OIRDLWYNX17AKDUDJmlMpIsA5eqcIZb.', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:53', '2023-12-27 07:46:53'),
(352, '1326d576-b488-48ed-9717-a89b0f1b1886', 'muhammadrafa', 'muhammadrafa@alittihadiya.com', '$2y$12$MQy/MJTKhh.KE5e8MlHuhOtnmK44zTkq4vo4xWo2HOkSCl.CbixwG', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:53', '2023-12-27 07:46:53'),
(353, 'fc77cf81-51bc-41c2-a135-1ac54cd7350e', 'aqilasyahirah', 'aqilasyahirah@alittihadiya.com', '$2y$12$YDsurnTQKedhw9lmUjHnz.wW8brCbyNDMQv1xqPR7ncclb0dKVSHS', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:53', '2023-12-27 07:46:53'),
(354, 'df3d25b1-ea8b-40ca-ae0e-2345f4a27832', 'sandrinalmira', 'sandrinalmira@alittihadiya.com', '$2y$12$YdFvOvYdI1/qluAXQW7UkO.eVdcrdaqs9cFgPncG7uQmcAeX2aF7e', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:54', '2023-12-27 07:46:54'),
(355, 'c6c8ad7d-3870-442f-9eb8-93e9318e43ee', 'fionaadelia\r\n', 'fionaadelia\r\n@alittihadiya.com', '$2y$12$HsFbP53RTKhOXxflarkmEeKZT.T5MYo/Z.201KfeZbWYRS9pLOp3O', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:54', '2023-12-27 07:46:54'),
(356, '2b50072a-671c-4fc2-b559-91aea461d56a', 'syahiraaulia', 'syahiraaulia@alittihadiya.com', '$2y$12$GmGaD3wCmUvsfIMfRg1qNui079U/HGU.oLYuCdUhXp.vW5cuCN4Uq', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:54', '2023-12-27 07:46:54'),
(357, '1c636cd5-9f12-430f-a058-67f12e754dbb', 'azrilathafariz', 'azrilathafariz@alittihadiya.com', '$2y$12$HLo6BHevQeVQKyVckXa6GuVxRPz6BSajNc6z4HZF6QeTNlsvUYo72', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:55', '2023-12-27 07:46:55'),
(358, 'eb17a273-9912-46df-b9fe-4f015e2d3dc1', 'gibranarzanka', 'gibranarzanka@alittihadiya.com', '$2y$12$IUQiD85YII.B1J2YhMC3VuE.FajyJs7vMwVMb0xVDrQcS2vzBftEi', NULL, 'siswa', 'active', NULL, '2023-12-27 07:46:55', '2023-12-27 07:46:55'),
(359, '9440566c-80b2-4f6e-a569-f9f1b8f9a208', 'muhammadal', 'muhammadal@alittihadiya.com', '$2y$12$Xyjx55295RxlNIy1PpHIyeGD1t3rc8tbOyLGsKCm5um21hFlbXN3G', NULL, 'siswa', 'active', NULL, '2023-12-27 07:57:09', '2023-12-27 07:57:09');

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
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

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
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

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
  ADD KEY `fk_kelas_guru` (`wali_kelas`),
  ADD KEY `fk_tahun_ajran` (`tahun_ajaran_id`);

--
-- Indexes for table `tbl_mapel_gurus`
--
ALTER TABLE `tbl_mapel_gurus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_guru_walikelas` (`id_guru`),
  ADD KEY `fk_mapel_walikelas` (`id_mapel`);

--
-- Indexes for table `tbl_mapping_mapel`
--
ALTER TABLE `tbl_mapping_mapel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ktsp_mapping_mapel_mapel_id_foreign` (`mapel_id`);

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
  ADD KEY `fk_kelas_siswa` (`id_kelas`),
  ADD KEY `fk_user_id` (`user_id`);

--
-- Indexes for table `tbl_tahun_ajarans`
--
ALTER TABLE `tbl_tahun_ajarans`
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `uuid` (`uuid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `log_tbl_kelas`
--
ALTER TABLE `log_tbl_kelas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=353;

--
-- AUTO_INCREMENT for table `log_tbl_wali_siswas`
--
ALTER TABLE `log_tbl_wali_siswas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_akuns`
--
ALTER TABLE `tbl_akuns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_beritas`
--
ALTER TABLE `tbl_beritas`
  MODIFY `id_berita` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tbl_bidang_studis`
--
ALTER TABLE `tbl_bidang_studis`
  MODIFY `id_mapel` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `tbl_ekstrakurikulers`
--
ALTER TABLE `tbl_ekstrakurikulers`
  MODIFY `id_ekskul` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_ekstrakurikuler_siswas`
--
ALTER TABLE `tbl_ekstrakurikuler_siswas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tbl_fasilitas`
--
ALTER TABLE `tbl_fasilitas`
  MODIFY `id_fasilitas` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_gurus`
--
ALTER TABLE `tbl_gurus`
  MODIFY `id_guru` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  MODIFY `id_kelas` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `tbl_mapel_gurus`
--
ALTER TABLE `tbl_mapel_gurus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `tbl_mapping_mapel`
--
ALTER TABLE `tbl_mapping_mapel`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_nilais`
--
ALTER TABLE `tbl_nilais`
  MODIFY `id_nilai` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_pegawais`
--
ALTER TABLE `tbl_pegawais`
  MODIFY `id_pegawai` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_prestasis`
--
ALTER TABLE `tbl_prestasis`
  MODIFY `id_prestasi` bigint(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_rosters`
--
ALTER TABLE `tbl_rosters`
  MODIFY `roster_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `tbl_tahun_ajarans`
--
ALTER TABLE `tbl_tahun_ajarans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_wali_siswas`
--
ALTER TABLE `tbl_wali_siswas`
  MODIFY `id_wali` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=360;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

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
  ADD CONSTRAINT `fk_tahun_ajran` FOREIGN KEY (`tahun_ajaran_id`) REFERENCES `tbl_tahun_ajarans` (`id`),
  ADD CONSTRAINT `fk_wali_kelas` FOREIGN KEY (`wali_kelas`) REFERENCES `tbl_gurus` (`id_guru`);

--
-- Constraints for table `tbl_mapel_gurus`
--
ALTER TABLE `tbl_mapel_gurus`
  ADD CONSTRAINT `fk_mapel_walikelas` FOREIGN KEY (`id_mapel`) REFERENCES `tbl_bidang_studis` (`id_mapel`),
  ADD CONSTRAINT `flk_mapel_guru` FOREIGN KEY (`id_guru`) REFERENCES `tbl_gurus` (`id_guru`);

--
-- Constraints for table `tbl_nilais`
--
ALTER TABLE `tbl_nilais`
  ADD CONSTRAINT `fk_mapel` FOREIGN KEY (`id_mapel`) REFERENCES `tbl_bidang_studis` (`id_mapel`),
  ADD CONSTRAINT `fk_nisn_siswa` FOREIGN KEY (`nisn_siswa`) REFERENCES `tbl_siswas` (`nisn`);

--
-- Constraints for table `tbl_rosters`
--
ALTER TABLE `tbl_rosters`
  ADD CONSTRAINT `fk_kelas_roster` FOREIGN KEY (`kelas`) REFERENCES `tbl_kelas` (`id_kelas`),
  ADD CONSTRAINT `fk_mapel_guru` FOREIGN KEY (`mapel_guru`) REFERENCES `tbl_mapel_gurus` (`id`);

--
-- Constraints for table `tbl_siswas`
--
ALTER TABLE `tbl_siswas`
  ADD CONSTRAINT `fk_kelas` FOREIGN KEY (`id_kelas`) REFERENCES `tbl_kelas` (`id_kelas`),
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`uuid`);

--
-- Constraints for table `tbl_wali_siswas`
--
ALTER TABLE `tbl_wali_siswas`
  ADD CONSTRAINT `fk_wali_siswa` FOREIGN KEY (`nisn`) REFERENCES `tbl_siswas` (`nisn`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
