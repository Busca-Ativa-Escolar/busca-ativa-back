# Usa imagem estável com suporte a wkhtmltopdf
FROM python:3.10-slim-bullseye

# Instala dependências do sistema e wkhtmltopdf
RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    build-essential \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libpng-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos da aplicação
COPY . /app

# Instala as dependências Python
RUN pip install --no-cache-dir -r requirements.txt

# Expõe a porta (Railway usa 8080 por padrão)
EXPOSE 8080

# Comando para iniciar a aplicação
CMD ["python", "app.py"]
