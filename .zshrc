
# Включаем базовый автокомплит Zsh
autoload -Uz compinit
compinit

# Подключаем серые подсказки на основе истории (как в Fish)
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Подключаем подсветку синтаксиса (зеленые/красные команды)
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Инициализируем промпт Starship со значками директорий
eval "$(starship init zsh)"
