FROM python:3.13-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN addgroup --system flask && adduser --system --group flask

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN chown -R flask:flask /app

USER flask

EXPOSE 5000

CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]