import airflow
from airflow import DAG
from datetime import timedelta
from airflow.providers.mysql.operators.mysql import MySqlOperator
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
    dag_id='mysqloperator_run_proc',
    #default_args=default_args,
    schedule_interval='* * * * *',
    start_date=days_ago(1),
    #schedule_interval='@once',
    dagrun_timeout=timedelta(minutes=60),
    description='run generate data procedure',
) as dag_mysql:

    sql_query = """use qlik_db;
    lock tables order_item WRITE;
    lock tables orders WRITE;
    START TRANSACTION;
    call call_generate;
    commit;"""

    before_run = BashOperator(
        task_id='start_procedure_call',
        bash_command='echo "Started another procedure call"',
    )

    run_procedure = MySqlOperator(sql=sql_query, task_id="Generate_random_order_data", mysql_conn_id="mysqldb",database="qlik_db", dag=dag_mysql)

    after_run = BashOperator(
        task_id='end_procedure_call',
        bash_command='echo "call_procedure_ran 1 time. Start another in 30 sec"',
    )

    before_run >> run_procedure >> after_run

if __name__ == "__main__":
    dag_mysql.cli()

