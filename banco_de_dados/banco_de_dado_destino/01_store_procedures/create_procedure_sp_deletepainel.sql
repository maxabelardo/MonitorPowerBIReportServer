/*****************************************************************************************************
Objeto: SP_DeletePasta

Tabelas vinculadas a SP:
	- Instancia.
	- Pasta.
	- Painel.
	- Auditoria.
    - LogError

Workflow:
	-Controle da auditoria.
		Para obter os dados antes da alteração será executado um select com os dados "@idinstancia" e "@ItemID" 
		na tabela no "[objects].[Pasta]".
		O select está dentro de um insert na tabelas "[auditing].[auditoria]" 
	- Executar o Update no banco desativando o objeto.
    - Caso algums das tarefas apresente erro será gravodo na tabelas "[auditing].[logerror]" o erro para analise.

Controle de erro:
Todas as tarefas da SP estaram dentro de um controle de erro chamado "Try catch" 
a SP só deverá ser finalizada com sucesso se todas as tarefas forem forem executadas com sucesso "COMMIT TRANSACTION;" caso alguma das tarefas 
apresentem erro todo os comandos seram desfeito "ROLLBACK TRANSACTION;" 


*****************************************************************************************************/

CREATE PROCEDURE [dbo].[sp_deletePainel]
    @idEstancia         [INT],
	@ItemID             NVARCHAR(40)
AS
BEGIN
	--Controle de erro.
	BEGIN TRANSACTION;  

		BEGIN TRY  
		    -- Auditoria.
            INSERT INTO [auditing].[auditoria]
                    ([TabName],[idRegistro],[acao],[valorAnterior])
            SELECT 'Pasta'     --TabName
                ,A.[idPasta] --idRegistro
                ,'DELETE'        --acao
                , CAST(@idEstancia  AS nvarchar(10))+' ; '+@ItemID+' ; '+A.[ParentID]+' ; '+A.[painel]+' ; '+A.[Localizacao]+' ; '+CAST(A.[DataDaCriacao] AS NVARCHAR(24))+' ; '+CAST(A.[DataDaModificacao] AS NVARCHAR(24))+' ; '+ CAST(A.[DiasSemAlteracao] AS NVARCHAR(3)) -- valorAnterior
            FROM [objects].[painel] AS A
				INNER JOIN [objects].[Pasta] AS P ON P.idPasta = A.idPasta
				INNER JOIN [objects].instancia AS I ON I.[idinstancia] = P.[idinstancia]
					WHERE I.[idinstancia] = @idEstancia
					  AND A.[itemid] = @ItemID

                --Desativa o objeto.
                UPDATE O
                   SET  O.[ativo] = 0
                FROM [objects].[painel] AS O
				INNER JOIN [objects].[Pasta] AS P ON P.idPasta = O.idPasta
				INNER JOIN [objects].instancia AS I ON I.[idinstancia] = P.[idinstancia]
				WHERE I.[idinstancia] = @idEstancia
				  AND O.[itemid] = @ItemID


		END TRY  
		BEGIN CATCH  -- Caso o alguns das etapas apresente erro a SP executar a insert na tabela "logerror"
			INSERT INTO [auditing].[logerror]
			   ([errorobjeto]
			   ,[errornumber]
			   ,[ErrorMessage]
			   ,[ErrorSeverity]
			   ,[ErrorState]
			   ,[ErrorLine])
				SELECT   
					 ERROR_PROCEDURE() AS ErrorProcedure  -- Retorna o nome da procedure que originou o erro.
					,ERROR_NUMBER() AS ErrorNumber        -- Numero do erro.
					,ERROR_MESSAGE() AS ErrorMessage      -- Menssagem do erro.  				
					,ERROR_SEVERITY() AS ErrorSeverity    -- Nível de criticidade 
					,ERROR_STATE() AS ErrorState          -- Retorna o número do estado do erro que causou a execução do bloco				
					,ERROR_LINE() AS ErrorLine;           -- Linha do código que causou o erro.
	        -- No casso de erro é executado um Rollback da transações.			
			IF @@TRANCOUNT > 0   
				ROLLBACK TRANSACTION;  
		END CATCH;  
		-- Se as tarefas forem executada com sucesso o Commit é executado salvando os dados nas tabelas de destino.
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION;  
END

GO


