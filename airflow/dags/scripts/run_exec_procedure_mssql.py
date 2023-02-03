import airflow
from airflow import DAG
from datetime import timedelta
from airflow.providers.microsoft.mssql.hooks.mssql import MsSqlHook
from airflow.providers.microsoft.mssql.operators.mssql import MsSqlOperator
from airflow.operators.bash import BashOperator
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'priyanshu',    
    'start_date': airflow.utils.dates.days_ago(2),
    # 'end_date': datetime(),
    # 'depends_on_past': False,
    'email': ['test@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    # If a task fails, retry it once after waiting
    # at least 5 minutes
    'retries': 1,
    'retry_delay': timedelta(minutes=2),
    }

with DAG(
    dag_id='mssqlserver_rexec_proc',
    #default_args=default_args,
    schedule_interval='* * * * *',
    start_date=days_ago(1),
    #schedule_interval='@once',
    dagrun_timeout=timedelta(minutes=60),
    description='run generate data procedure',
) as dag_mssql:

    sql_query = """use retail_db;
    exec call_generate;
    ;"""

    before_run = BashOperator(
        task_id='start_procedure_call_mssql',
        bash_command='echo "Started another procedure call"',
    )

    run_procedure_msql = MsSqlOperator(sql=sql_query, task_id="Generate_random_data_mssql", mssql_conn_id="mssqlserver", dag=dag_mssql)

    after_run = BashOperator(
        task_id='end_procedure_call_mssql',
        bash_command='echo "call_procedure_ran 1 time. Start another in 30 sec"',
    )

    before_run >> run_procedure_msql >> after_run

if __name__ == "__main__":
    dag_mysql.cli()

