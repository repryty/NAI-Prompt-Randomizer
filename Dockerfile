FROM node:18-alpine

RUN apk add --no-cache wget

# 앱 디렉토리 구조 (install.sh가 ../로 csv 이동하므로)
WORKDIR /app
RUN mkdir -p NAI-Prompt-Randomizer

# 소스 복사
COPY . /app/NAI-Prompt-Randomizer/

# 데이터셋 다운로드 (install.sh 역할)
RUN wget "https://huggingface.co/Jio7/NAI-Prompt-Randomizer/resolve/main/tags.csv?download=true" -O /app/tags.csv && \
    wget "https://huggingface.co/Jio7/NAI-Prompt-Randomizer/resolve/main/key.csv?download=true" -O /app/key.csv && \
    wget "https://huggingface.co/Jio7/NAI-Prompt-Randomizer/resolve/main/pos.csv?download=true" -O /app/pos.csv

WORKDIR /app/NAI-Prompt-Randomizer

RUN npm install --omit=dev

EXPOSE 80

CMD ["node", "index.js"]
