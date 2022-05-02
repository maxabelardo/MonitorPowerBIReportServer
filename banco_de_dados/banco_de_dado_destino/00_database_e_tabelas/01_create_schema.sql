/*********************************************************************************************
Schema:
    A base de dados é separada em objetos, sergurança, atualização e auditoria, cada item deverá ser um "schema" dentro do banco de dados.

        objetos     = objects
        sergurança  = security
        atualização = updating
        auditoria   = auditing

Com está metodologia podemos ter um controle melhor na liberação de acesso aos usuários em ações futuras.

*********************************************************************************************/

CREATE SCHEMA [objects] AUTHORIZATION [dbo]
GO
CREATE SCHEMA [security] AUTHORIZATION [dbo]
GO
CREATE SCHEMA [updating] AUTHORIZATION [dbo]
GO
CREATE SCHEMA [auditing] AUTHORIZATION [dbo]
GO