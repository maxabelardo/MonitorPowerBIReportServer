/*****************************************************************************************************
Objeto: SP_UpdatePasta

Tabelas vinculadas a SP:
	- Pasta.
	- Auditoria.
    - LogError

Workflow:
	-Controle da auditoria.
		Para obter os dados antes da alteração será executado um select com os dados "@idinstancia" e "@ItemID" 
		na tabela no "[objects].[Pasta]".
		O select está dentro de um insert na tabelas "[auditing].[auditoria]" 
	- Executar o Update no banco.
    - Caso algums das tarefas apresente erro será gravodo na tabelas "[auditing].[logerror]" o erro para analise.

Controle de erro:
Todas as tarefas da SP estaram dentro de um controle de erro chamado "Try catch" 
a SP só deverá ser finalizada com sucesso se todas as tarefas forem forem executadas com sucesso "COMMIT TRANSACTION;" caso alguma das tarefas 
apresentem erro todo os comandos seram desfeito "ROLLBACK TRANSACTION;" 


*****************************************************************************************************/

CREATE PROCEDURE [dbo].[sp_updatepasta]
    @idinstancia         [INT],                  -- Id da estância do portal.
	@ItemID             NVARCHAR(40),           -- Id interno do objeto.
    @Pasta              nvarchar(425),          -- Novo nome da pasta
	@Localizacao        nvarchar(425),          -- Nova localização
	@DataDaCriacao      datetime,               -- Nova data de criação.
	@DataDaModificacao  datetime,               -- Nova data de modificação
	@DiasSemAlteracao   int,                    -- Dias sem Alteração.
	@Nivel              int                     -- Nível do objeto.
AS
BEGIN
	--Controle de erro.
	BEGIN TRANSACTION;  

		BEGIN TRY  
		    -- Auditoria.
			INSERT INTO [dbo].[auditoria]
					   ([TabName],[idRegistro],[acao],[valorAnterior],[valorDepois])
				SELECT 'Pasta'     --TabName
					 , A.[idPasta] --idRegistro
					 , 'UPDATE'    --acao
					 , CAST(A.[idinstancia] AS nvarchar(10))+' ; '+A.[ItemID]+' ; '+A.[ParentID]+' ; '+A.[Pasta]+' ; '+A.[Localizacao]+' ; '+CAST(A.[DataDaCriacao] AS NVARCHAR(24))+' ; '+CAST(A.[DataDaModificacao] AS NVARCHAR(24))+' ; '+ CAST(A.[DiasSemAlteracao] AS NVARCHAR(3))+' ; '+ CAST(A.[Nivel] AS NVARCHAR(3)) -- Valor antes da Ateração.
					 , CAST(A.[idinstancia] AS nvarchar(10))+' ; '+A.[ItemID]+' ; '+A.[ParentID]+' ; '+@Pasta   +' ; '+@Localizacao+   ' ; '+CAST(@DataDaCriacao AS NVARCHAR(24))+   ' ; '+CAST(@DataDaModificacao AS NVARCHAR(24))+   ' ; '+ CAST(@DiasSemAlteracao AS NVARCHAR(3))+   ' ; '+ CAST(@Nivel AS NVARCHAR(3)) -- Valor depois da alteração.
				  FROM [objects].[Pasta] AS A
					  WHERE A.[idinstancia]  = @idinstancia
						AND A.[ItemID]      = @ItemID

			-- Update
			UPDATE [objects].[Pasta]
			   SET [Pasta]              = @Pasta
				  ,[Localizacao]        = @Localizacao
				  ,[DataDaCriacao]      = @DataDaCriacao
				  ,[DataDaModificacao]  = @DataDaModificacao
				  ,[DiasSemAlteracao]   = @DiasSemAlteracao
				  ,[Nivel]              = @Nivel
			 WHERE [idinstancia] = @idinstancia
			   AND [ItemID] = @ItemID

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


