# Imagem base do Python
FROM python:3.10-slim

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    wget \
    fontconfig \
    libfreetype6 \
    libjpeg62-turbo \
    libpng16-16 \
    libx11-6 \
    libxext6 \
    libxrender1 \
    libssl3 \
    xfonts-75dpi \
    xfonts-base \
    build-essential \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
 && wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb \
 && apt-get install -y ./wkhtmltox_0.12.6-1.buster_amd64.deb \
 && rm -f wkhtmltox_0.12.6-1.buster_amd64.deb \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Criar e definir o diretório de trabalho
WORKDIR /app

# Copiar os arquivos da aplicação
COPY . /app

# Instalar dependências Python
RUN pip install --no-cache-dir -r requirements.txt

# Definir a variável de ambiente para permitir que o Gunicorn ouça em todos os IPs
ENV PORT=8080
ENV HOST=0.0.0.0

EXPOSE 8080

# Comando para rodar o Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:${PORT}", "app:app"]
