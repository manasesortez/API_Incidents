<?php

class IncidentesController
{
    public IncidentesGateway $gateway;

    public function __construct(IncidentesGateway $gateway)
    {
        $this->gateway = $gateway;
    }
    
    public function processRequest(string $method, ?string $id): void
    {
        if ($id) {
            
            $this->processResourceRequest($method, $id);
            
        } else {
            
            $this->processCollectionRequest($method);
            
        }
    }
    
    private function processResourceRequest(string $method, string $id): void
    {
        $incidente = $this->gateway->get($id);
        
        if ( ! $incidente) {
            http_response_code(404);
            echo json_encode(["message" => "Incidente not found"]);
            return;
        }
        
        switch ($method) {
            case "GET":
                echo json_encode($incidente);
                break;
                
            case "PATCH":
                $data = (array) json_decode(file_get_contents("php://input"), true);
                
                $errors = $this->getValidationErrors($data);
                
                if ( ! empty($errors)) {
                    http_response_code(422);
                    echo json_encode(["errors" => $errors]);
                    break;
                }
                
                $rows = $this->gateway->update($incidente, $data);
                
                echo json_encode([
                    "message" => "Incidente $id updated",
                    "rows" => $rows
                ]);
                break;
                
            case "DELETE":
                $rows = $this->gateway->delete($id);
                
                echo json_encode([
                    "message" => "Incidente $id deleted",
                    "rows" => $rows
                ]);
                break;
                
            default:
                http_response_code(405);
                header("Allow: GET, PATCH, DELETE");
        }
    }
    
    private function processCollectionRequest(string $method): void
    {
        switch ($method) {
            case "GET":
                echo json_encode($this->gateway->getAll());
                break;
                
            case "POST":
                $data = (array) json_decode(file_get_contents("php://input"), true);
                
                $errors = $this->getValidationErrors($data);
                
                if ( ! empty($errors)) {
                    http_response_code(422);
                    echo json_encode(["errors" => $errors]);
                    break;
                }
                
                $id = $this->gateway->create($data);
                
                http_response_code(201);
                echo json_encode([
                    "message" => "Incidente created",
                    "id" => $id
                ]);
                break;
            
            default:
                http_response_code(405);
                header("Allow: GET, POST");
        }
    }
    
    private function getValidationErrors(array $data): array
    {
        $errors = [];
        
        if (empty($data["id_tipo_incidente"])) {
            $errors[] = "Tipo Incidente es requerido";
        }
        
        if (empty($data["descripcion_incidente"])) {
            $errors[] = "descripcion es requerido";
        }

        if (empty($data["id_usuario"])) {
            $errors[] = "usuario es requerido";
        }

        if (empty($data["id_estado"])) {
            $errors[] = "estado es requerido";
        }
        
        return $errors;
    }
}









