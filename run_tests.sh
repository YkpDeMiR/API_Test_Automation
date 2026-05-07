#!/bin/bash

# Renk tanımları
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "🚀 API Test Otomasyonu Başlıyor..."
echo "=================================="

# Results klasörünü temizle
rm -rf results/*

# Testleri çalıştır ve sonucu direkt kontrol et
if robot \
  --outputdir results \
  --log results/log.html \
  --report results/report.html \
  --output results/output.xml \
  tests/; then
  echo -e "${GREEN}✅ Tüm testler başarıyla geçti!${NC}"
else
  echo -e "${RED}❌ Bazı testler başarısız!${NC}"
fi

echo "=================================="
echo "📊 Rapor: results/report.html"
