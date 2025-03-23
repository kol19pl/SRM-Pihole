#!/bin/bash
set -e

# Ustawienia pakietu dla pi-hole
packageName="pi-hole"
version="v5.10"              # Dostosuj wersję do aktualnej
arch="ipq806x"               # lub "x86_64" – zależnie od docelowej architektury
firmware="5.2-9283"
maintainer="Pi-hole Project"
displayname="Pi-hole"
maintainer_url="https://pi-hole.net"
support_url="https://discourse.pi-hole.net/"
helpurl="https://docs.pi-hole.net/"
adminport=80
adminurl="web"
dsmuidir="ui"
beta="no"
install_replace_packages="pi-hole"
install_conflict_packages="pi-hole"
install_replace_force_packages="pi-hole"

# Katalog roboczy dla budowy pakietu (tymczasowy)
workDir=$(pwd)/${packageName}_build

# Usunięcie starego katalogu roboczego (jeśli istnieje) i stworzenie nowej struktury
rm -rf "$workDir"
mkdir -p "$workDir"

# Tworzenie struktury katalogów:
# - Plik INFO (na poziomie głównym)
# - package/target (pliki aplikacji)
# - package/scripts (skrypty startowe i stop)
mkdir -p "$workDir/package/target"
mkdir -p "$workDir/package/scripts"

# Tworzenie pliku INFO z metadanymi pakietu
cat <<EOF > "$workDir/INFO"
package="$packageName"
version="$version"
description="Pi-hole is a network-wide ad blocker that protects your devices from ads and tracking."
arch="$arch"
firmware="$firmware"
maintainer="$maintainer"
displayname="$displayname"
maintainer_url="$maintainer_url"
support_url="$support_url"
helpurl="$helpurl"
adminport=$adminport
adminurl="$adminurl"
dsmuidir="$dsmuidir"
beta="$beta"
install_replace_packages="$install_replace_packages"
install_conflict_packages="$install_conflict_packages"
install_replace_force_packages="$install_replace_force_packages"
EOF

# Klonowanie repozytorium pi-hole do tymczasowego katalogu
repoDir="$workDir/pi-hole-repo"
echo "⬇ Klonowanie repozytorium pi-hole..."
git clone https://github.com/pi-hole/pi-hole.git "$repoDir"

# Kopiowanie tylko wymaganych plików z repozytorium do katalogu target
echo "📂 Kopiowanie plików do package/target..."
cp -r "$repoDir/." "$workDir/package/target/"

# Tworzenie skryptów startowych i stop
echo "📝 Tworzenie skryptów startowych..."
cat <<EOF > "$workDir/package/scripts/start.sh"
#!/bin/sh
# Przykładowe polecenie startowe - dostosuj wg potrzeb
/opt/$packageName/pi-hole/start.sh &
exit 0
EOF

cat <<EOF > "$workDir/package/scripts/stop.sh"
#!/bin/sh
# Przykładowe polecenie zatrzymujące - dostosuj wg potrzeb
killall "$packageName"
EOF

# Ustawienie uprawnień wykonywalności dla skryptów
chmod +x "$workDir/package/scripts/start.sh" "$workDir/package/scripts/stop.sh"

# Tworzenie archiwum .tgz z plikami pakietu
echo "📦 Tworzenie archiwum tar.gz (package.tgz)..."
tar -czf "$workDir/package.tgz" -C "$workDir/package" .

# Tworzenie finalnego pliku .spk, zawierającego INFO oraz package.tgz
outputFile=$(pwd)/${packageName}.spk
echo "📦 Tworzenie pakietu .spk: $outputFile"
cd "$workDir"
tar -cf "$outputFile" INFO package.tgz

echo "✅ Pakiet utworzony: $outputFile"
