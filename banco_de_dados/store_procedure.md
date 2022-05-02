# STORE PROCEDURE
Na base de dados deste projetos existe diversas SP que executan uma infinidade de tarefas, neste documento vamos listar cada uma deles e explicação o seu funcionamento.

_Store_ _procedure_ ou _"SP"_ são funções que são utilizadas para encapsular tarefas a serem executadas no servidor de banco de dados, estas tarefas poderiam ser feita pela aplicação porem vão ser executadas dentro do banco.


## Lista das Store procedure.


### O ETL utilizará as SP_Update*** para autalizar os dados no banco.

#### SP_UpdatePasta
Atualisando a tabela _"Pasta"_
A SP será utilizada para agregar as tarefas de auditoria e update "atualização' da tabela _"Pasta"_. 

Scritp de execução da SP:
```
-- Parâmentro para executar a SP.
DECLARE @idEstancia int                -- Id da estância do portal.  
DECLARE @ItemID nvarchar(40)           -- Id interno do objeto. 
DECLARE @Pasta nvarchar(425),          -- Novo nome da pasta
DECLARE @Localizacao nvarchar(425)     -- Nova localização
DECLARE @DataDaCriacao datetime        -- Nova data de criação.
DECLARE @DataDaModificacao datetime    -- Nova data de modificação
DECLARE @DiasSemAlteracao int          -- Dias sem Alteração.
DECLARE @Nivel int                     -- Nível do objeto.

EXECUTE [dbo].[SP_UpdatePasta] 
   @idEstancia
  ,@ItemID
  ,@Pasta
  ,@Localizacao
  ,@DataDaCriacao
  ,@DataDaModificacao
  ,@DiasSemAlteracao
  ,@Nivel
GO

```
Script interno da SP _"SP_UpdatePasta"_
```

CREATE PROCEDURE [dbo].[SP_UpdatePasta]
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

/*Toda tarefa da SP estara dentro de um controle de erro chamado "Try catch" 
a SP só deverá receber o comando de concluido se todas as tafefas forem executadas com sucesso. */
	BEGIN TRANSACTION;  

		BEGIN TRY  
		   /*   Nesta etapa da SP será feito o controle da auditoria.
			 Para obter os dados antes da alteração será executado um select com os dados "@idinstancia" e "@ItemID" 
			 na tabela no "[objects].[Pasta]".
			 O select está dentro de um insert na tabelas "[auditing].[auditoria]" */
			INSERT INTO [dbo].[Auditoria]
					   ([TabName],[idRegistro],[acao],[valorAnterior],[valorDepois])
				SELECT 'Pasta'     --TabName
					 , A.[idPasta] --idRegistro
					 , 'UPDATE'    --acao
					 , CAST(A.[idinstancia] AS nvarchar(10))+' ; '+A.[ItemID]+' ; '+A.[ParentID]+' ; '+A.[Pasta]+' ; '+A.[Localizacao]+' ; '+CAST(A.[DataDaCriacao] AS NVARCHAR(24))+' ; '+CAST(A.[DataDaModificacao] AS NVARCHAR(24))+' ; '+ CAST(A.[DiasSemAlteracao] AS NVARCHAR(3))+' ; '+ CAST(A.[Nivel] AS NVARCHAR(3)) -- Valor antes da Ateração.
					 , CAST(A.[idinstancia] AS nvarchar(10))+' ; '+A.[ItemID]+' ; '+A.[ParentID]+' ; '+@Pasta   +' ; '+@Localizacao+   ' ; '+CAST(@DataDaCriacao AS NVARCHAR(24))+   ' ; '+CAST(@DataDaModificacao AS NVARCHAR(24))+   ' ; '+ CAST(@DiasSemAlteracao AS NVARCHAR(3))+   ' ; '+ CAST(@Nivel AS NVARCHAR(3)) -- Valor depois da alteração.
				  FROM [objects].[Pasta] AS A
					  WHERE A.[idinstancia]  = @idinstancia
						AND A.[ItemID]      = @ItemID

			-- Despois da auditoria ter sido gravado no banco o Update será executado.
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

```





## Refências:
* [TRY...CATCH (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/language-elements/try-catch-transact-sql?view=sql-server-ver15)
* [ERROR_PROCEDURE (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/functions/error-procedure-transact-sql?view=sql-server-ver15)
* [ERROR_NUMBER (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/functions/error-number-transact-sql?view=sql-server-ver15)
* [ERROR_MESSAGE (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/functions/error-message-transact-sql?view=sql-server-ver15)
* [ERROR_SEVERITY (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/functions/error-severity-transact-sql?view=sql-server-ver15)
* [ERROR_STATE (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/functions/error-state-transact-sql?view=sql-server-ver15)
* [ERROR_LINE (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/functions/error-line-transact-sql?view=sql-server-ver15)
