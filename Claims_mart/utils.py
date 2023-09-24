from configparser import ConfigParser
import psycopg2


def config(filename='database.ini', section='postgresql'):
    parser = ConfigParser()
    parser.read(filename)

    db = {}
    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            db[param[0]] = param[1]
    else:
        raise Exception('Section {0} was not found in {1} file'.format(
            section, filename))
    return db


def sql_create_table(table_name, table_columns):
    return f"""
        CREATE TABLE IF NOT EXISTS {table_name} (
            {','.join(table_columns)}
        );
    """


def load_data_to_db(path_to_file, db_connection, table_name):
    try:
        db_cursor = db_connection.cursor()
        sql = f"""
            TRUNCATE TABLE {table_name}
        """
        db_cursor.execute(sql)
        db_connection.commit()
        sql = f"""
            COPY {table_name}
            FROM STDOUT (FORMAT CSV)
        """
        with open(path_to_file) as f:
            next(f)
            db_cursor.copy_expert(sql, f)
            db_connection.commit()
        return True
    except psycopg2.Error as e:
        print(e)
        return False
    finally:
        db_cursor.close()
print(config())
