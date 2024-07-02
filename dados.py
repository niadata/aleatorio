# Instalar pacotes necessários
!pip install faker pandas openpyxl
from faker import Faker
import pandas as pd
import random
from datetime import datetime, timedelta
# Inicializar o Faker
fake = Faker('pt_BR')
# Configurar seed para reprodutibilidade
Faker.seed(0)
random.seed(0)
# Definir número de registros
num_records = 1000
# Listas de regiões e segmentos de exemplo
regioes = ['Norte', 'Sudeste',]
segmentos = ['Tecnologia', 'Saude', 'Comercio', 'Educacao', 'Industria']
portes = ['Micro', 'Pequeno', 'Medio']
# Função para gerar status baseado na data de fechamento
def generate_status(data_abertura, data_fechamento):
    if data_fechamento:
        return 1
    else:
        return 0

# Função para determinar a probabilidade de fechamento
def should_close(porte, regiao):
    if porte == 'Micro' and regiao == 'Norte':
        return random.random() > 0.3  # 70% chance de fechar
    elif porte == 'Micro':
        return random.random() > 0.5  # 50% chance de fechar
    elif regiao == 'Norte':
        return random.random() > 0.6  # 40% chance de fechar
    else:
        return random.random() > 0.7  # 30% chance de fechar
# Gerar dados fictícios
data = []
for _ in range(num_records):
    empresa_id = fake.uuid4()
    data_abertura = fake.date_between(start_date='-10y', end_date='today')

    regiao = random.choice(regioes)
    segmento = random.choice(segmentos)
    porte = random.choice(portes)

    # Determinar se a empresa deve fechar com base no porte e na região
    if should_close(porte, regiao):
        data_fechamento = fake.date_between(start_date=data_abertura, end_date='today')
    else:
        data_fechamento = None

    status = generate_status(data_abertura, data_fechamento)

    data.append({
        'ID': empresa_id,
        'Abertura': data_abertura,
        'Fechamento': data_fechamento,
        'Regiao': regiao,
        'Segmento': segmento,
        'Porte': porte,
        'Status': status
    })
# Criar DataFrame
df = pd.DataFrame(data)
# Certificar-se de que as colunas de data estão no tipo datetime
df['Abertura'] = pd.to_datetime(df['Abertura'])
df['Fechamento'] = pd.to_datetime(df['Fechamento'])
# Salvar em um arquivo CSV
df.to_csv('empresas_ficticias.csv', index=False)

print("Banco de dados fictício criado e salvo como 'empresas_ficticias.csv'")
# Salvar em um arquivo Excel
df.to_excel('empresas_ficticias.xlsx', index=False)

print("Banco de dados fictício criado e salvo como 'empresas_ficticias.xlsx'")
