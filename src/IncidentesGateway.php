<?php

class IncidentesGateway
{
    private PDO $conn;
    
    public function __construct(Database $database)
    {
        $this->conn = $database->getConnection();
    }
    
    public function getAll(): array
    {
        $sql = "SELECT *
                FROM tbl_incidentes";
                
        $stmt = $this->conn->query($sql);
        
        $data = [];
        
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $data[] = $row;
        }
        
        return $data;
    }
    
    public function create(array $data): string
    {
        $sql = "INSERT INTO tbl_incidentes(id_tipo_incidente, descripcion_incidente, fecha_incidente,id_usuario,imagen_incidente,id_estado) VALUES (:id_tipo_incidente, :descripcion_incidente, :fecha_incidente,:id_usuario,:imagen_incidente,:id_estado);";
            
        $stmt = true;

        $stmt = $this->conn->prepare($sql);
        
        $stmt->bindValue(":id_tipo_incidente", $data["id_tipo_incidente"] ?? 0, PDO::PARAM_INT);
        $stmt->bindValue(":descripcion_incidente", $data["descripcion_incidente"], PDO::PARAM_STR);
        $stmt->bindValue(":fecha_incidente", $data["fecha_incidente"], PDO::PARAM_STR);
        $stmt->bindValue(":id_usuario", $data["id_usuario"] ?? 0, PDO::PARAM_INT);
        $stmt->bindValue(":imagen_incidente", $data["imagen_incidente"], PDO::PARAM_STR);
        $stmt->bindValue(":id_estado", $data["id_estado"] ?? 0, PDO::PARAM_INT);

        $stmt->execute();

                
        return $this->conn->lastInsertId();
    }
    
    public function get(string $id)
    {
        $sql = "SELECT * FROM tbl_incidentes WHERE id_incidente = :id_incidente";
                
        $stmt = $this->conn->prepare($sql);
        
        $stmt->bindValue(":id_incidente", $id, PDO::PARAM_INT);
        
        $stmt->execute();
        
        $data = $stmt->fetch(PDO::FETCH_ASSOC);
        
        return $data;
    }
    
    public function update(array $current, array $new): int
    {
        $sql = "UPDATE tbl_incidentes SET id_tipo_incidente = :id_tipo_incidente,  descripcion_incidente = :descripcion_incidente, fecha_incidente = :fecha_incidente, id_usuario = :id_usuario, imagen_incidente = :imagen_incidente, id_estado = :id_estado WHERE id_incidente = :id_incidente";
                
        $stmt = $this->conn->prepare($sql);
        
        $stmt->bindValue(":id_tipo_incidente", $new["id_tipo_incidente"] ?? $current["id_tipo_incidente"], PDO::PARAM_INT);
        $stmt->bindValue(":descripcion_incidente", $new["descripcion_incidente"] ?? $current["descripcion_incidente"], PDO::PARAM_STR);
        $stmt->bindValue(":fecha_incidente", $new["fecha_incidente"] ?? $current["fecha_incidente"], PDO::PARAM_STR);
        $stmt->bindValue(":id_usuario", $new["id_usuario"] ?? $current["id_usuario"], PDO::PARAM_INT);
        $stmt->bindValue(":imagen_incidente", $new["imagen_incidente"] ?? $current["imagen_incidente"], PDO::PARAM_STR);
        $stmt->bindValue(":id_estado", $new["id_estado"] ?? $current["id_estado"], PDO::PARAM_INT);
        
        $stmt->bindValue(":id_incidente", $current["id_incidente"], PDO::PARAM_INT);
        
        $stmt->execute();
        
        return $stmt->rowCount();
    }
    
    public function delete(string $id): int
    {
        $sql = "DELETE FROM tbl_incidentes WHERE id_incidente = :id_incidente";
                
        $stmt = $this->conn->prepare($sql);
        
        $stmt->bindValue(":id_incidente", $id, PDO::PARAM_INT);
        
        $stmt->execute();
        
        return $stmt->rowCount();
    }
}











