import logging
from db_connection import connect_db
from utils import load_data_to_db, sql_create_table

logging.basicConfig(format='%(asctime)s - %(message)s', level=logging.INFO)

# Podać ścieżkę do plików .csv
path_to_motor_file = 'src_motor.csv'
path_to_claim_file = 'src_claim.csv'
path_to_exposure_file = 'src_exposure.csv'


motor_columns = [
    'mid text',
    'ld text',
    'vrn text',
    'y text',
    'm text',
    'mo text',
    'ec text',
    'col text',
    'dd text',
    'tld text',
    'pav text',
    'rc text',
    'amfv text',
    'pn text',
    'ddob text',
    'ft text',
    'd text',
    's text',
    'id text'
]
claim_columns = [
    'cdi text',
    'pl text',
    'lo text',
    'pn text',
    'ld text',
    't text',
    'cb text',
    'ct text',
    'c text',
    'fr text',
    'hr text',
    'lc text',
    'lt text',
    'situation text',
    'id text'
]
exposure_columns = [
    'eid text',
    'cid text',
    'et text',
    'tp text',
    'id text'
]

connection = connect_db()
if connection:
    logging.info("Connection to db is established")
    cursor = connection.cursor()

    sql = """
        CREATE SCHEMA IF NOT EXISTS dbt_demo_raw_data;
    """
    cursor.execute(sql)
    logging.info("Schema 'dbt_demo_raw_data' was created")
    connection.commit()
    sql = sql_create_table(
        table_name='dbt_demo_raw_data.motor',
        table_columns=motor_columns
    )
    cursor.execute(sql)
    logging.info("Table 'motor' was created")
    connection.commit()

    sql = sql_create_table(
        table_name='dbt_demo_raw_data.claim',
        table_columns=claim_columns
    )
    cursor.execute(sql)
    logging.info("Table 'claim' was created")
    connection.commit()

    sql = sql_create_table(
        table_name='dbt_demo_raw_data.exposure',
        table_columns=exposure_columns
    )
    cursor.execute(sql)
    logging.info("Table 'exposure' was created")
    connection.commit()

    if_loaded = load_data_to_db(
        path_to_file=path_to_exposure_file,
        db_connection=connection,
        table_name='dbt_demo_raw_data.exposure'
    )
    if if_loaded:
        logging.info("Exposure data loaded to db")
    else:
        logging.info("Oops, something went wrong, data were not loaded to db")

    if_loaded = load_data_to_db(
        path_to_file=path_to_motor_file,
        db_connection=connection,
        table_name='dbt_demo_raw_data.motor'
    )
    if if_loaded:
        logging.info("Motor data loaded to db")
    else:
        logging.info("Oops, something went wrong, data were not loaded to db")

    if_loaded = load_data_to_db(
        path_to_file=path_to_claim_file,
        db_connection=connection,
        table_name='dbt_demo_raw_data.claim'
    )
    if if_loaded:
        logging.info("Claim data loaded to db")
    else:
        logging.info("Oops, something went wrong, data were not loaded to db")
    cursor.close()
    connection.close()
else:
    logging.error("Could not establish connection to db")
