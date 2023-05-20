FROM python:3.9-slim
WORKDIR ~
COPY . .

RUN pip install --upgrade pip
RUN pip install poetry

RUN poetry config virtualenvs.create false
RUN poetry install

CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8080"]
