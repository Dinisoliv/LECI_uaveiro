[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/0MZJIdpt)
# Trabalho 1 AED 2024-2025

Este é o código-fonte para o primeiro projeto de AED 2024-2025.

## Ficheiros

- `imageBW.c` - implementação do módulo (a COMPLETAR)
- `imageBW.h` - interface do módulo
- `instrumentation.[ch]` - módulo para contagens de operações e medição de tempos
- `imageBWTest.c` - programa de teste simples
- `imageBWTool.c` - programa de teste mais versátil
- `Makefile` - regras para compilar e testar usando `make`

- `README.md` - estas informações que está a ler

## Descarregar imagens

Execute:

- `make pbm` - para descarregar imagens para pasta `pbm/`
- `make setup` - para descarregar imagens para testes em `test/`

## Compilar

- `make` - Compila e gera os programas de teste.
- `make clean` - Limpa ficheiros objeto e executáveis.

## Atualizar repositório


Dada a natureza do trabalho, poderá ser necessário
atualizar repositório base (upstream) deste projeto.
Se isso acontecer, deverá atualizar o seu repositório de duas formas

Pode actualizar através da página do repositório.
Sempre que o repositório original contiver commits novos em relação ao seu pode clicar em:

```
Sync fork
```

Se quiser actualizar através da linha de comandos:

```bash
git remote add upstream git@github.com/detiuaveiro/aed-imageBW-public.git

git fetch upstream
git checkout main
git merge --allow-unrelated-histories upstream/main
# (Resolver quaisquer conflitos que surjam...)
git commit
```
