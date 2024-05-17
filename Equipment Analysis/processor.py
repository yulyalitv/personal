import pandas as pd
import glob
import datetime

RAW_DATA_PATH = '../data/raw'
PROCESSED_DATA_PATH = '../data/processed'
OUTPUT_DATA_PATH = '../data/output'

def add_atribute(ser: pd.Series) -> str:
    string = ser['Описание позиции'].lower()
    if string.__contains__('трансп')|string.__contains__('доставк'):
        return 'Доставка'
    elif string.__contains__('монтаж'):
        return 'Монтаж'
    else: 
        return 'Оборудование'

def add_atribute2(ser: pd.Series) -> str:
    string = ser['Описание позиции'].lower()
    words1 = ['система', "крепления"]
    words2 = ['стойка', 'с', 'полками']
    words3 = ['стойка', 'с', 'лотками']
    words4 = ['решетка', 'освещения']
    words5 = ['рещетка', 'освещения']
    words6 = ['решётка', 'освещения']
    words7 = ['рещётка', 'освещения']
    siskrep = ' '.join(words1)
    ssp = ' '.join(words2)
    ssl = ' '.join(words3)
    resh1 = ' '.join(words4)
    resh2 = ' '.join(words5)
    resh3 = ' '.join(words6)
    resh4 = ' '.join(words7)

    if string.__contains__('рама'):
        return 'Рамы'
    elif string.__contains__('стойка') | string.__contains__('база') | string.__contains__('адаптер'):
        return 'Стойки'
    elif string.__contains__('балка') | string.__contains__('перекладина') | string.__contains__('опора'):
        return 'Балки'
    elif string.__contains__('связь'):
        return 'Связи'
    elif string.__contains__('диагонал'):
        return 'Диагонали'
    elif string.__contains__('стикер'):
        return 'Стикеры'
    elif string.__contains__('траверс'):
        return 'Траверсы'
    elif string.__contains__('полка'):
        return 'Полки'

    elif string.__contains__('патерностер') | string.__contains__('сладок') | string.__contains__('рельс') | string.__contains__('ремень') | string.__contains__('sladok') | string.__contains__('планшет') | string.__contains__('вал'):
        return 'Патерностеры'

    elif string.__contains__('консол'):
        return 'Кантилеверы'

    elif string.__contains__('касс'):
        return 'Кассы'

    elif string.__contains__('тележк') | string.__contains__('волоколамское'):
        return 'Тележки'

    elif string.__contains__(resh1) | string.__contains__(resh2) | string.__contains__(resh3) | string.__contains__(resh4) | string.__contains__('электрошин'):
        return 'Решетка освещения'
    elif string.__contains__('boston'):
        return 'Панели Бостон'

    elif string.__contains__('штабел'):
        return 'Штабелируемые паллеты'
    elif string.__contains__('корзин') | string.__contains__('разделител') | string.__contains__('накопител') | string.__contains__('сепаратор'):
        return 'Корзины'
    elif string.__contains__('крю') | string.__contains__('держател') | string.__contains__('брошь') | string.__contains__(siskrep) | string.__contains__('ценникодержател'):
        return 'Крючки'
    elif string.__contains__('рамка') | string.__contains__('перегородк'):
        return 'Рамки'
    elif string.__contains__('стеллаж') | string.__contains__('стенд') | string.__contains__(ssp) | string.__contains__(ssl):
        return 'Стенды'
    elif string.__contains__('панел') | string.__contains__('перф'):
        return 'Панели'
    elif string.__contains__('кросс'):
        return 'Кроссы'
    elif string.__contains__('каскет'):
        return 'Каскеты'
    elif string.__contains__('модул') | string.__contains__('бокс') | string.__contains__('подставка') | string.__contains__('экспози'):
        return 'Экспозиторы'
    elif string.__contains__('кронштейн') | string.__contains__('петл') | string.__contains__('крепеж') | string.__contains__('стопор'):
        return 'Кронштейны'
    elif string.__contains__('лоток'):
        return 'Лотки'
    else:
        return 'Прочее'


path_list = glob.glob(f'{RAW_DATA_PATH}/iproc/*.xlsx')
print('IProc files:', path_list)
df = pd.concat([pd.read_excel(path, header=11, engine='openpyxl') for path in path_list])
print(df.head())
df['Название поставщика'] = df['Название поставщика'].str.lower()
print(df.columns)

vendors = pd.read_excel(f'{RAW_DATA_PATH}/Поставщики.xlsx', engine='openpyxl')
vendors['Название поставщика'] = vendors['Название поставщика'].str.lower()
print(vendors.head(3))

df = df.merge(vendors[['Название поставщика', 'Тип поставщика']], how='left',
              left_on='Название поставщика', right_on='Название поставщика')
df['Тип поставщика'] = df['Тип поставщика'].fillna('Прочее')
df['Атрибут'] = df.apply(add_atribute, axis=1)
df['Детальная разбивка'] = df.apply(add_atribute2, axis=1)
print(df.head(3))

df.to_excel(f'{OUTPUT_DATA_PATH}/processed_data.xlsx', engine='openpyxl')

thr5h
trhrttukiykl
tyujetyjtrht
shtsjhj
