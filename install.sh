#!/bin/bash
set -eu

# 実行場所のディレクトリを取得
THIS_DIR=$(cd $(dirname $0); pwd)

echo 'start sym link'
for f in .??*; do
    [[ ${f} = ".git" ]] && continue
    [[ ${f} = ".gitignore" ]] && continue
    ln -snfv ${THIS_DIR}/${f} ${HOME}/${f}
done

echo 'done!!!!!!!'
