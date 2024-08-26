import pandas as pd
from sqlalchemy  import create_engine
data=pd.read_csv('employee_survey_data.csv')
df=pd.DataFrame(data)
username='mjsql'
password='Manoj@1981'
host='127.0.0.1'
db='EMPLOYEE'
port='3306'
engine = create_engine(f'mysql+pymysql://{username}:{password} @ {host}:{port}/{db}')
table_name='employee_survey_data'
df.to_sql(table_name,con=engine,if_exists='replace',index=False)
