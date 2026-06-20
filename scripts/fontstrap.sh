#!/usr/bin/env bash
# =============================================================================
#  Font Bundle Installer for Arch Linux
#  Cobre: emojis, scripts internacionais, fontes de sistema e tipografia.
# =============================================================================

set -euo pipefail

# ── Cores ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GRN='\033[0;32m'
YLW='\033[1;33m'
BLU='\033[0;34m'
CYN='\033[0;36m'
BLD='\033[1m'
RST='\033[0m'

# ── Helpers ──────────────────────────────────────────────────────────────────
info()    { echo -e "${BLU}${BLD}[INFO]${RST}  $*"; }
ok()      { echo -e "${GRN}${BLD}[ OK ]${RST}  $*"; }
warn()    { echo -e "${YLW}${BLD}[WARN]${RST}  $*"; }
section() { echo -e "\n${CYN}${BLD}══ $* ══${RST}"; }
hr()      { echo -e "${CYN}────────────────────────────────────────────────────${RST}"; }

# ── Verificações iniciais ─────────────────────────────────────────────────────
if [[ $EUID -eq 0 ]]; then
  warn "Não rode como root. O script usa sudo quando necessário."
  exit 1
fi

command -v pacman &>/dev/null || { echo "pacman não encontrado. Este script é para Arch Linux."; exit 1; }

# Detecta helper AUR (paru > yay > makepkg)
AUR_HELPER=""
for h in paru yay; do
  command -v "$h" &>/dev/null && { AUR_HELPER="$h"; break; }
done

if [[ -z "$AUR_HELPER" ]]; then
  warn "Nenhum helper AUR encontrado (paru/yay). Pacotes AUR serão ignorados."
  warn "Instale paru ou yay para cobertura completa."
fi

# ── Listas de pacotes ─────────────────────────────────────────────────────────

# Pacotes disponíveis nos repositórios oficiais do Arch
OFFICIAL=(
  # ── Emojis ─────────────────────────────────────────────────────────────────
  noto-fonts-emoji            # Google Noto Emoji (colorido, padrão amplamente usado)
  ttf-twemoji                 # Twitter Emoji (colorido, alternativa popular)

  # ── Noto – cobertura de scripts do mundo inteiro ───────────────────────────
  noto-fonts                  # Latin, Greek, Cyrillic, e muitos outros
  noto-fonts-cjk              # Chinês, Japonês, Coreano (Han unificado)
  noto-fonts-extra            # Scripts raros: Armeniano, Ge'ez, Ogham, etc.

  # ── Fontes de sistema / interface ──────────────────────────────────────────
  ttf-dejavu                  # DejaVu Sans/Serif/Mono — fallback clássico
  gnu-free-fonts              # FreeSans, FreeSerif, FreeMono
  ttf-liberation              # Métricas compatíveis com Arial/Times/Courier

  # ── Árabe, Persa, Urdu ─────────────────────────────────────────────────────
  ttf-arabeyes-fonts          # Arabeyes Sharif, Kacst
  ttf-amiri                   # Amiri — tipografia árabe clássica

  # ── Indiano (Devanagari, Bengali, Tamil, Telugu…) ─────────────────────────
  ttf-indic-otf               # OpenType fonts para scripts índicos

  # ── Armênio, Georgiano, Etíope ─────────────────────────────────────────────
  ttf-baekmuk                 # Coreano Baekmuk (fallback extra CJK)

  # ── Simbolos e matematica ──────────────────────────────────────────────────
  ttf-font-awesome            # Ícones amplamente usados em UIs
  ttf-math-noto               # Noto Sans Math — símbolos matemáticos

  # ── Tipografia ocidental de qualidade ──────────────────────────────────────
  ttf-linux-libertine         # Libertine / Biolinum — alternativa ao Times/Arial
  ttf-ubuntu-font-family      # Ubuntu — excelente legibilidade
  ttf-roboto                  # Roboto — fonte Material Design
  ttf-opensans                # Open Sans — amplamente usada na web
  ttf-droid                   # Droid Sans/Serif — cobertura Latin + muitos scripts
  ttf-inconsolata             # Inconsolata — monospace para terminal/código
  ttf-fira-code               # Fira Code — monospace com ligaduras
  ttf-jetbrains-mono          # JetBrains Mono — monospace popular para devs
  ttf-hack                    # Hack — monospace clean para terminais

  # ── CJK alternativo ────────────────────────────────────────────────────────
  wqy-microhei                # WenQuanYi Micro Hei (Chinese)
  wqy-zenhei                  # WenQuanYi Zen Hei (Chinese)

  # ── Tailandês, Lao, Khmer ──────────────────────────────────────────────────
  ttf-tlwg                    # Thai Linux Working Group fonts

  # ── Hebraico ───────────────────────────────────────────────────────────────
  culmus-fonts                # Coleção de fontes Hebraicas Culmus
)

# Pacotes apenas no AUR
AUR=(
  # ── Emojis adicionais ──────────────────────────────────────────────────────
  ttf-joypixels              # JoyPixels emoji (alta qualidade)

  # ── Nerd Fonts (ícones + glyphs para Neovim/terminal) ─────────────────────
  ttf-nerd-fonts-symbols-mono # Apenas os glyphs — leve e universal
  nerd-fonts-jetbrains-mono   # JetBrains Mono com Nerd Font glyphs

  # ── Birmanês / Myanmar ────────────────────────────────────────────────────
  ttf-myanmar3                # Myanmar3 unicode font

  # ── Tibetano ──────────────────────────────────────────────────────────────
  ttf-tibetan-machine-uni     # Tibetan Machine Uni

  # ── Sinhala ───────────────────────────────────────────────────────────────
  ttf-lklug                   # LKLUG Sinhala font

  # ── Tipografia extra ──────────────────────────────────────────────────────
  ttf-ms-fonts                # Arial, Times New Roman, etc. (compat. Office)
  ttf-google-fonts-git        # Coleção completa Google Fonts (pesado, opcional)
)

# =============================================================================
#  INSTALAÇÃO
# =============================================================================

echo ""
echo -e "${BLD}╔══════════════════════════════════════════════════════════╗${RST}"
echo -e "${BLD}║         Font Bundle Installer — Arch Linux               ║${RST}"
echo -e "${BLD}╚══════════════════════════════════════════════════════════╝${RST}"
echo ""

# ── 1. Repositórios oficiais ──────────────────────────────────────────────────
section "Repositórios Oficiais (pacman)"
info "Atualizando base de dados de pacotes..."
sudo pacman -Sy --noconfirm

FAILED_OFFICIAL=()
for pkg in "${OFFICIAL[@]}"; do
  # ignora linhas de comentário que escaparam (segurança)
  [[ "$pkg" == \#* ]] && continue

  if pacman -Qi "$pkg" &>/dev/null; then
    ok "$pkg (já instalado)"
  else
    if sudo pacman -S --noconfirm --needed "$pkg" 2>/dev/null; then
      ok "$pkg"
    else
      warn "Falhou: $pkg"
      FAILED_OFFICIAL+=("$pkg")
    fi
  fi
done

# ── 2. AUR ────────────────────────────────────────────────────────────────────
if [[ -n "$AUR_HELPER" ]]; then
  section "AUR ($AUR_HELPER)"
  FAILED_AUR=()
  for pkg in "${AUR[@]}"; do
    [[ "$pkg" == \#* ]] && continue

    if pacman -Qi "$pkg" &>/dev/null; then
      ok "$pkg (já instalado)"
    else
      if $AUR_HELPER -S --noconfirm --needed "$pkg" 2>/dev/null; then
        ok "$pkg"
      else
        warn "Falhou: $pkg"
        FAILED_AUR+=("$pkg")
      fi
    fi
  done
else
  section "AUR — pulado (nenhum helper)"
  warn "Os seguintes pacotes não foram instalados:"
  for pkg in "${AUR[@]}"; do
    [[ "$pkg" == \#* ]] && continue
    echo "  • $pkg"
  done
fi

# ── 3. Regenerar cache de fontes ─────────────────────────────────────────────
section "Cache de Fontes"
info "Executando fc-cache..."
fc-cache -fv &>/dev/null && ok "Cache regenerado com sucesso."

# ── 4. Relatório final ────────────────────────────────────────────────────────
section "Relatório"

if [[ ${#FAILED_OFFICIAL[@]} -gt 0 ]]; then
  warn "Pacotes oficiais que falharam:"
  for p in "${FAILED_OFFICIAL[@]}"; do echo "  • $p"; done
fi

if [[ -n "$AUR_HELPER" && ${#FAILED_AUR[@]} -gt 0 ]]; then
  warn "Pacotes AUR que falharam:"
  for p in "${FAILED_AUR[@]}"; do echo "  • $p"; done
fi

hr
ok "Instalação concluída!"
echo ""
echo -e "  ${BLD}Cobertura instalada:${RST}"
echo "  • Emojis coloridos (Noto Emoji, Twemoji)"
echo "  • Árabe / Persa / Hebraico"
echo "  • Indiano (Devanagari, Tamil, Bengali, Telugu…)"
echo "  • CJK — Chinês, Japonês, Coreano"
echo "  • Tailandês, Tibetano, Birmanês, Sinhala"
echo "  • Cirílico, Grego, Armeniano, Georgiano"
echo "  • Matemática e símbolos especiais"
echo "  • Fontes monospace para terminal/Neovim"
echo "  • Tipografia Latin de qualidade (Roboto, Ubuntu, Inter…)"
echo ""
echo -e "  ${YLW}Dica:${RST} reinicie aplicações gráficas para carregar as novas fontes."
hr
