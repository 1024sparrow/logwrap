# logwrap - утилита, помогающая выяснить, с какими аргументами запускаются имеющиеся в системе приложения

Данная утилита была написана в рамках разработки [android-console-build-tools](https://github.com/1024sparrow/android-console-build-tools): надо было узнать порядок запуска и аргументы инструментов сборки приложения под Android с зависимостями AndroidStudio-ей.

# Установка

Перед установкой укажите явно полные пути до файлов логов в файле ```logwrap.sh```

Запустите в консоли из той директории, куда выкачали данный репозиторий:
```bash
$ sudo ./install.sh
```

Для удаления:
```bash
$ sudo ./uninstall
```

Для обновления достаточно простого ```git pull``` в директории, откуда производилась установка.

# Что делает утилита

Допустим, мы хотим залогировать ключи запуска утилиты ```/usr/local/bin/traliva```.

Выполняем в консоли:
```bash
$ sudo logwrap /usr/local/bin/traliva
```
Выполняем под рутом, так как обычному пользователю доступ к директории ```/usr/local/bin/``` закрыт.

Данная утилита производит следующие действия:

- целевой файл ```/usr/local/bin/traliva``` переименовывает в ```/usr/local/bin/logwrap_traliva```;
- пишет bash-скрипт ```/usr/local/bin/traliva```, который выводит все аргументы в лог, и запускает с теми аргументами ```/usr/local/bin/logwrap_traliva```.

За один раз передать несколько файлов нельзя, так что, если надо нескольким бинарникам добавить логирование, используйте bash-цикл:
```bash
$ cd /usr/local/bin
$ for i in traliva_1 traliva_2 traliva_3;do sudo logwrap $i; done
```

Для отключения логирования бинарника, замените XXX на logwrap_XXX:
```bash
$ mv logwrap_traliva traliva
```

# Особый случай - логирование утилит из /snap/... (Ubuntu)

Раздел ```/snap/...``` монтируется только для чтения, так что сходу добавить логирование к тем бинарникам нам не получится.
Команда ```mount``` нам даёт:
```
...
/var/lib/snapd/snaps/android-studio_113.snap on /snap/android-studio/113 type squashfs (ro,nodev,relatime,x-gdu.hide)
/var/lib/snapd/snaps/android-studio_114.snap on /snap/android-studio/114 type squashfs (ro,nodev,relatime,x-gdu.hide)
...
```
Меня интересует раздел конкретно 114-й.

Поэтому, перед тем как запускать утилиту ```logwrap```, необходимо перемонтировать раздел с правами записи:

```bash
sudo umount /snap/android-studio/114
```
