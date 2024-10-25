# ECS Infrastructure as Code (IaC) con Terraform

## 📋 Descripción
Este proyecto implementa una infraestructura completa de ECS (Elastic Container Service) en AWS utilizando Terraform. 
Diseñado para desplegar aplicaciones containerizadas de manera escalable y altamente disponible.

## 🏗️ Arquitectura

### Componentes Principales
- **ECS Cluster**: Cluster para gestionar contenedores
- **Application Load Balancer (ALB)**: Balanceador de carga para distribuir el tráfico
- **Auto Scaling Group (ASG)**: Escalado automático de instancias EC2
- **Target Groups**: Gestión de endpoints para el balanceo de carga
- **Security Groups**: Control de acceso y seguridad
- **VPC & Networking**: Configuración de red y subredes
Variables Requeridas

ecr_registry: URL del registro ECR
ecr_repository: Nombre del repositorio en ECR
execution_role_arn: ARN del rol de ejecución de ECS

📊 Monitoreo y Mantenimiento

Métricas de CloudWatch configuradas
Logs de contenedores
Health checks del ALB
Monitoreo del Auto Scaling

🛡️ Seguridad

HTTPS habilitado
Security Groups restrictivos
Network ACLs configuradas
IAM roles con mínimos privilegios

📝 Notas importantes

Los Security Groups están configurados para permitir solo el tráfico necesario
El Auto Scaling está configurado para mantener alta disponibilidad
Los logs están habilitados para debugging y monitoreo
