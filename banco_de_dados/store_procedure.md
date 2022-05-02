# STORE PROCEDURE
Na base de dados deste projetos existe diversas SP que executan uma infinidade de tarefas, neste documento vamos listar cada uma deles e explicação o seu funcionamento.

_Store_ _procedure_ ou _"SP"_ são funções que são utilizadas para encapsular tarefas a serem executadas no servidor de banco de dados, estas tarefas poderiam ser feita pela aplicação porem vão ser executadas dentro do banco.


## Lista das Store procedure.


### SP_UpdatePasta
A SP será utilizada para agregar a tarefas de auditoria e update "atualização' da tabela _"Pasta"_ , o ETL utilizará esta SP sempre que for necessario atualizar o dado

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

```





## Refências:
* [TRY...CATCH (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/language-elements/try-catch-transact-sql?view=sql-server-ver15)
* [ERROR_PROCEDURE (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/functions/error-procedure-transact-sql?view=sql-server-ver15)
* [ERROR_NUMBER (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/functions/error-number-transact-sql?view=sql-server-ver15)
* [ERROR_MESSAGE (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/functions/error-message-transact-sql?view=sql-server-ver15)
* [ERROR_SEVERITY (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/functions/error-severity-transact-sql?view=sql-server-ver15)
* [ERROR_STATE (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/functions/error-state-transact-sql?view=sql-server-ver15)
* [ERROR_LINE (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/functions/error-line-transact-sql?view=sql-server-ver15)
