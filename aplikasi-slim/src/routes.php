<?php

use Slim\App;
use Slim\Http\Request;
use Slim\Http\Response;

return function (App $app) {
    $container = $app->getContainer();

    $app->get('/[{name}]', function (Request $request, Response $response, array $args) use ($container) {
        // Sample log message
        $container->get('logger')->info("Slim-Skeleton '/' route");

        // Render index view
        return $container->get('renderer')->render($response, 'index.phtml', $args);
    });

    //LOGIN
        //Validasi
        $app->post("/Validasi", function (Request $request, Response $response, $args){
            $dtReq = $request->getParsedBody();
            $sql = "SELECT * FROM usergoogle WHERE username =:username";
            $stmt = $this->db->prepare($sql);
            
            $data = [
                ":username" => $dtReq["username"],
            ];
            $result = $stmt->fetchAll();
        
            if($result != null)
            return $response->withJson(["status" => "success", "data" => "1"], 200);
            
            return $response->withJson(["status" => "failed", "data" => "0"], 200);
        });

        //Register Mahasiswa
        $app->post("/Mhs/Register/", function (Request $request, Response $response){

            $new_dt = $request->getParsedBody();
        
            $sql = "INSERT INTO mahasiswa (nim, namaMhs, username) VALUE (:nim, :namaMhs, :username)";
            $stmt = $this->db->prepare($sql);
            $result = $stmt->fetch();
        
            $data = [
                ":nim" => $new_dt["nim"],
                ":namaMhs" => $new_dt["namaMhs"],
                ":username" => $new_dt["username"]
            ];
        
            if($stmt->execute($data))
            return $response->withJson(["status" => "success", "data" => "1"], 200);
            
            return $response->withJson(["status" => "failed", "data" => "0"], 200);
        });

        //Register Dosen
        $app->post("/Dosen/Register/", function (Request $request, Response $response){

            $new_dt = $request->getParsedBody();
        
            $sql = "INSERT INTO dosen (nidn, namaDosen, username) VALUE (:nidn, :namaDosen, :username)";
            $stmt = $this->db->prepare($sql);
            $result = $stmt->fetch();
        
            $data = [
                ":nidn" => $new_dt["nidn"],
                ":namaDosen" => $new_dt["namaDosen"],
                ":username" => $new_dt["username"],
            ];
        
            if($stmt->execute($data))
            return $response->withJson(["status" => "success", "data" => "1"], 200);
            
            return $response->withJson(["status" => "failed", "data" => "0"], 200);
        });

        // usergoogle

        $app->post("/UserGoogle/Add/", function (Request $request, Response $response){

            $new_dt = $request->getParsedBody();
        
            $sql = "INSERT INTO usergoogle (username,role,id) VALUE (:username,:role,:id)";
            $stmt = $this->db->prepare($sql);
        
            $data = [
                ":username" => $new_dt["username"],
                ":role" => $new_dt["role"],
                ":id" => $new_dt["id"]
               
            ];
        
            if($stmt->execute($data))
            return $response->withJson(["status" => "success", "data" => "1"], 200);
        });

        $app->post("/UserGoogle/Validate", function (Request $request, Response $response, $args){
            $new_dt = $request->getParsedBody();
           
            $sql = "SELECT * FROM usergoogle Where username=:username";
            $stmt = $this->db->prepare($sql);
            $data = [
                ":username" => $new_dt["username"]
            ];
            $stmt->execute($data);
            $result = $stmt->fetchAll();
            
            return $response->withJson($result, 200);
            
            
        });

        $app->get("/UserGoogle/getall", function (Request $request, Response $response, $args){
            $sql = "SELECT * FROM usergoogle";
            $stmt = $this->db->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll();
            return $response->withJson($result, 200);
        });

        $app->get("/UserGoogle/{username}", function (Request $request, Response $response, $args){
            $id = $args["username"];
            $sql = "SELECT * FROM usergoogle Where username=:username";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([":username" => $id]);
            $result = $stmt->fetch();
            return $response->withJson($result, 200);
        });


        //GRAFIKKKKKKKKKKKKKKKKKKKKKKKKKKKK
        $app->get("/GetallJanjian/{nidn}", function (Request $request, Response $response, $args){
            $id = $args["nidn"];
            $sql = "SELECT * FROM janjian WHERE nidn=:nidn";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([":nidn" => $id]);
            $result = $stmt->fetchAll();
            return $response->withJson($result, 200);
        });


    //DOSEN
        //Menampilkan semua dosen = bisa
        $app->get("/DosenGetAll/", function (Request $request, Response $response){
            $sql = "SELECT * FROM dosen";
            $stmt = $this->db->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll();
            return $response->withJson($result, 200);
        });

        //Menampilkan dosen berdasarkan nidn nya
        $app->get("/DosenGetByID/{nidn}", function (Request $request, Response $response, $args){
            $id = $args["nidn"];
            $sql = "SELECT * FROM dosen Order BY nidn=:nidn";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([":nidn" => $id]);
            $result = $stmt->fetch();
            return $response->withJson([$result], 200);
        });

        //Add jadwal janjian, aktor=dosen
        $app->post("/Dosen/CreateJanjian/", function (Request $request, Response $response){

            $new_janjian = $request->getParsedBody();
        
            $sql = "INSERT INTO janjian (nidn, tgl, jam, sttsJanjian, isAvailable, createdBy) VALUE (:nidn, :tgl, :jam, :sttsJanjian, :isAvailable, :createdBy)";
            $stmt = $this->db->prepare($sql);
            $result = $stmt->fetch();
        
            $data = [
                ":nidn" => $new_janjian["nidn"],
                ":tgl" => $new_janjian["tgl"],
                ":jam" => $new_janjian["jam"],
                ":sttsJanjian" => $new_janjian["sttsJanjian"],
                ":isAvailable" => $new_janjian["isAvailable"],
                ":createdBy" => $new_janjian["createdBy"],
            ];
        
            if($stmt->execute($data))
            return $response->withJson(["status" => "success", "data" => "1"], 200);
            
            return $response->withJson(["status" => "failed", "data" => "0"], 200);
        });

        //Read Melihat daftar janjian yang dimiliki dosen, aktor = dosen
        $app->get("/Dosen/LihatJanjian/{nidn}", function (Request $request, Response $response, $args){
            $id = $args["nidn"];
            $sql = "SELECT * FROM janjian WHERE nidn=:nidn";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([":nidn" => $id]);
            $result = $stmt->fetchAll();
            return $response->withJson(["status" => "success", "data" => $result], 200);
        });

        //Read Melihat daftar janjian yang dibuat dosen, belum di updte mhs
        $app->get("/Dosen/LihatJanjianTersedia/{nidn}", function (Request $request, Response $response, $args){
            $id = $args["nidn"];
            $sql = "SELECT * FROM janjian WHERE nidn=:nidn and isAvailable='TRUE'";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([":nidn" => $id]);
            $result = $stmt->fetchAll();
            return $response->withJson($result, 200);
        });

        //Update Janjian, aktor=dosen
        $app->post("/Dosen/UpdateJanjian/", function (Request $request, Response $response, $args){
            $new_janjian = $request->getParsedBody();
            $sql = "UPDATE janjian SET nim=:nim, nidn=:nidn, tgl=:tgl, jam=:jam, tempat=:tempat, ketJanjian=:ketJanjian, sttsJanjian=:sttsJanjian, isAvailable=:isAvailable, createdBy=:createdBy WHERE kd_janjian=:kd_janjian";
            $stmt = $this->db->prepare($sql);
            
            $data = [
                ":kd_janjian" => $new_janjian["kd_janjian"],
                ":nim" => $new_janjian["nim"],
                ":nidn" => $new_janjian["nidn"],
                ":tgl" => $new_janjian["tgl"],
                ":jam" => $new_janjian["jam"],
                ":tempat" => $new_janjian["tempat"],
                ":ketJanjian" => $new_janjian["ketJanjian"],
                ":sttsJanjian" => $new_janjian["sttsJanjian"],
                ":isAvailable" => $new_janjian["isAvailable"],
                ":createdBy" => $new_janjian["createdBy"]
            ];
        
            if($stmt->execute($data))
            return $response->withJson(["status" => "success", "data" => "1"], 200);
            
            return $response->withJson(["status" => "failed", "data" => "0"], 200);
        });

        //Delete Janjian, aktor=dosen
        $app->delete("/Dosen/DeleteJanjian/{kd_janjian}", function (Request $request, Response $response, $args){
            $kd_janjian = $args["kd_janjian"];
            $sql = "DELETE FROM janjian WHERE kd_janjian=:kd_janjian";
            $stmt = $this->db->prepare($sql);
            
            $data = [
                ":kd_janjian" => $kd_janjian
            ];
        
            if($stmt->execute($data))
            return $response->withJson(["status" => "success", "data" => "1"], 200);
            
            return $response->withJson(["status" => "failed", "data" => "0"], 200);
        });

        //Verifikasi Janjian, aktor=dosen
        $app->get("/Dosen/VerifikasiJanjian/{kd_janjian}", function (Request $request, Response $response, $args){
            $kd_janjian = $args["kd_janjian"];
            $sql = "UPDATE janjian SET sttsJanjian='2' WHERE kd_janjian=:kd_janjian";
            $stmt = $this->db->prepare($sql);
        
            $stmt->execute([":kd_janjian" => $kd_janjian]);
            return $response->withJson(["status" => "success", "data" => "1"], 200);
        });

        $app->get("/Dosen/VerifikasiJanjian/tolak/{kd_janjian}", function (Request $request, Response $response, $args){
            $kd_janjian = $args["kd_janjian"];
            $sql = "UPDATE janjian SET sttsJanjian='3' WHERE kd_janjian=:kd_janjian";
            $stmt = $this->db->prepare($sql);
        
            $stmt->execute([":kd_janjian" => $kd_janjian]);
            return $response->withJson(["status" => "success", "data" => "1"], 200);
        });

        //Verifikasi Janjian, aktor=dosen
        $app->get("/Dosen/BatalkanJanjian/{kd_janjian}", function (Request $request, Response $response, $args){
            $kd_janjian = $args["kd_janjian"];
            $sql = "UPDATE janjian SET sttsJanjian='4' WHERE kd_janjian=:kd_janjian";
            $stmt = $this->db->prepare($sql);
        
            $stmt->execute([":kd_janjian" => $kd_janjian]);
            return $response->withJson(["status" => "success", "data" => "1"], 200);
        });

        //menampilkan semua
        $app->get("/Dosen/verifikasi/{nidn}", function (Request $request, Response $response, $args){
            $id = $args["nidn"];
            $sql = "SELECT * FROM janjian WHERE nidn=:nidn and sttsJanjian='MENUNGGU' and nim != 'NULL'";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([":nidn" => $id]);
            $result = $stmt->fetchAll();
        return $response->withJson( $result, 200);
        });

        //menampilkan janjian yang createdby=dosen

        $app->get("/Janjian/Created/Dosen/{nidn}", function (Request $request, Response $response, $args){
            $id = $args["nidn"];
            $sql = "SELECT * FROM janjian where nidn=:nidn AND createdBy = 'dosen' ";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([":nidn" => $id]);
            $result = $stmt->fetchAll();
            return $response->withJson($result, 200);
        });


        //menampilkan janjian yang createdby=mhs
        
        $app->get("/Janjian/Created/mhs/{nidn}", function (Request $request, Response $response, $args){
            $id = $args["nidn"];
            $sql = "SELECT * FROM janjian where nidn=:nidn AND createdBy != 'dosen' ";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([":nidn" => $id]);
            $result = $stmt->fetchAll();
            return $response->withJson($result, 200);
        });

        $app->get("/DosenViewAllJanjian/{nidn}", function (Request $request, Response $response, $args){
            $id = $args["nidn"];
            $sql = "SELECT * FROM janjian where nidn=:nidn";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([":nidn" => $id]);
            $result = $stmt->fetchAll();
            return $response->withJson($result, 200);
        });

        //Read melihat jadwal janjian yang tersedia berdasarkan dosen tertentu, aktor=dosen
        $app->get("/Dosen/LihatJanjianDosenTersedia/{nidn}", function (Request $request, Response $response, $args){
            $id = $args["nidn"];
            $sql = "SELECT * FROM janjian WHERE isAvailable=TRUE AND nidn=:nidn AND sttsJanjian='MENUNGGU'";
            $stmt = $this->db->prepare($sql);   
            $stmt->execute([":nidn" => $id]);

            $result = $stmt->fetchAll();
        return $response->withJson($result, 200);
        
        });






    //MAHASISWA

        //Menampilkan semua dosen = bisa
        $app->get("/MahasiswaGetAll/", function (Request $request, Response $response){
            $sql = "SELECT * FROM mahasiswa";
            $stmt = $this->db->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll();
            return $response->withJson($result, 200);
        });


        //Add Janjian (Menambah jadwal janjian diluar jadwal dosen, aktor=mhs)
        $app->post("/Mhs/CreateJanjian/", function (Request $request, Response $response){

            $new_janjian = $request->getParsedBody();
        
            $sql = "INSERT INTO janjian (nim, nidn, tgl, jam, tempat, ketJanjian,sttsJanjian, isAvailable, createdBy) VALUE (:nim, :nidn, :tgl, :jam, :tempat, :ketJanjian,:sttsJanjian, :isAvailable, :createdBy)";
            $stmt = $this->db->prepare($sql);
            $result = $stmt->fetch();
        
            $data = [
                ":nim" => $new_janjian["nim"],
                ":nidn" => $new_janjian["nidn"],
                ":tgl" => $new_janjian["tgl"],
                ":jam" => $new_janjian["jam"],
                ":tempat" => $new_janjian["tempat"],
                ":ketJanjian" => $new_janjian["ketJanjian"],
                ":sttsJanjian" => $new_janjian["sttsJanjian"],
                ":isAvailable" => $new_janjian["isAvailable"],
                ":createdBy" => $new_janjian["createdBy"]
            ];
        
            if($stmt->execute($data))
            return $response->withJson(["status" => "success", "data" => "1"], 200);
            
            return $response->withJson(["status" => "failed", "data" => "0"], 200);
        });

    
        //Update Janjian (Menambah jadwal janjian sesuai dgn jadwal dosen, aktor=mhs)
        $app->post("/Mhs/UpdateJanjian/", function (Request $request, Response $response, $args){
            $new_janjian = $request->getParsedBody();
            $sql = "UPDATE janjian SET nim=:nim, nidn=:nidn, tgl=:tgl, jam=:jam, tempat=:tempat, ketJanjian=:ketJanjian, sttsJanjian=:sttsJanjian, isAvailable=:isAvailable, createdBy=:createdBy WHERE kd_janjian=:kd_janjian";
            $stmt = $this->db->prepare($sql);
            
            $data = [
                ":kd_janjian" => $new_janjian["kd_janjian"],
                ":nim" => $new_janjian["nim"],
                ":nidn" => $new_janjian["nidn"],
                ":tgl" => $new_janjian["tgl"],
                ":jam" => $new_janjian["jam"],
                ":tempat" => $new_janjian["tempat"],
                ":ketJanjian" => $new_janjian["ketJanjian"],
                ":sttsJanjian" => $new_janjian["sttsJanjian"],
                ":isAvailable" => $new_janjian["isAvailable"],
                ":createdBy" => $new_janjian["createdBy"]
            ];
        
            if($stmt->execute($data))
            return $response->withJson(["status" => "success", "data" => "1"], 200);
            
            return $response->withJson(["status" => "failed", "data" => "0"], 200);
        });


        //Read melihat jadwal janjian all oleh mhs tertentu
        $app->get("/Mhs/JanjianbyNim/{nim}", function (Request $request, Response $response, $args){
            $id = $args["nim"];
            $sql = "SELECT * FROM janjian WHERE nim=:nim";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([":nim" => $id]);
            $result = $stmt->fetchAll();
        return $response->withJson( $result, 200);
        
        });


        //Read melihat jadwal janjian disetujui
        $app->get("/Mhs/JanjianDisetujui/{nim}", function (Request $request, Response $response, $args){
            $id = $args["nim"];
            $sql = "SELECT * FROM janjian WHERE nim=:nim and sttsJanjian='DISETUJUI'";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([":nim" => $id]);
            $result = $stmt->fetchAll();
        return $response->withJson( $result, 200);
        
        });

        //Read melihat jadwal janjian ditolak
        $app->get("/Mhs/JanjianDitolak/{nim}", function (Request $request, Response $response, $args){
            $id = $args["nim"];
            $sql = "SELECT * FROM janjian WHERE nim=:nim and sttsJanjian='DITOLAK'";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([":nim" => $id]);
            $result = $stmt->fetchAll();
        return $response->withJson( $result, 200);
        
        });


        //Read melihat jadwal janjian yang tersedia berdasarkan dosen tertentu, aktor=mhs
        $app->get("/Mhs/LihatJanjianDosen/{nidn}", function (Request $request, Response $response, $args){
            $id = $args["nidn"];
            $sql = "SELECT * FROM janjian WHERE isavailable=TRUE AND nidn=:nidn";
            $stmt = $this->db->prepare($sql);   
            $stmt->execute([":nidn" => $id]);

            $result = $stmt->fetchAll();
        return $response->withJson($result, 200);
        
        });

        //Read menampilkan jadwal janjian yang tersedia berdasarkan kd_janjian, aktor=mhs
        $app->get("/Mhs/ShowJanjianByKodeJanjian/{kd_janjian}", function (Request $request, Response $response, $args){
            $id = $args["kd_janjian"];
            $sql = "SELECT * FROM janjian WHERE isavailable=TRUE AND kd_janjian=:kd_janjian";
            $stmt = $this->db->prepare($sql);   
            $stmt->execute([":kd_janjian" => $id]);

            $result = $stmt->fetchAll();
        return $response->withJson($result, 200);
        
        });


        //Delete Janjian, aktor=Mahasiswa
        $app->delete("/Mhs/DeleteJanjian/{kd_janjian}", function (Request $request, Response $response, $args){
            $kd_janjian = $args["kd_janjian"];
            $sql = "DELETE FROM janjian WHERE kd_janjian=:kd_janjian";
            $stmt = $this->db->prepare($sql);
            
            $data = [
                ":kd_janjian" => $kd_janjian
            ];
        
            if($stmt->execute($data))
            return $response->withJson(["status" => "success", "data" => "1"], 200);
            
            return $response->withJson(["status" => "failed", "data" => "0"], 200);
        });
};
