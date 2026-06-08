# Stage 1: Kompilasi aplikasi (Builder)
FROM golang:1.26-alpine AS builder

WORKDIR /app

# Salin berkas modul dan unduh dependensi
COPY go.mod go.sum ./
RUN go mod download

# Salin seluruh kode sumber proyek
COPY . .

# Buat berkas biner aplikasi
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# Stage 2: Menjalankan aplikasi dengan image yang sangat ringan
FROM alpine:latest

WORKDIR /app

# Salin file biner dari stage builder sebelumnya
COPY --from=builder /app/main .

# Sesuai dengan kode main.go Anda yang menggunakan port 3000
EXPOSE 3000

# Perintah untuk menjalankan aplikasi backend Anda
CMD ["./main"]
