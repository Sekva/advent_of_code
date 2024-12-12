def na_principal(matriz, i, j, tabela):
    if matriz[i][j] != 'X':
        return False
    ret = matriz[i][j:j+4] == 'XMAS'
    if ret:
        tabela[i][j:j+4] = matriz[i][j:j+4]
    return ret

def reverso(matriz, i, j, tabela):
    if matriz[i][j] != 'S':
        return False
    ret = matriz[i][j:j+4] == 'SAMX'
    if ret:
        tabela[i][j:j+4] = matriz[i][j:j+4]
    return ret

def vertical_normal(matriz, i, j, tabela):
    try:
        for off_i in range(4):
            if matriz[i+off_i][j] != "XMAS"[off_i]:
                return False
        for off_i in range(4):
            tabela[i+off_i][j] = matriz[i+off_i][j]
        return True
    except:
        return False

def vertical_reverso(matriz, i, j, tabela):
    try:
        for off_i in range(4):
            if matriz[i+off_i][j] != "SAMX"[off_i]:
                return False
        for off_i in range(4):
            tabela[i+off_i][j] = matriz[i+off_i][j]
        return True
    except:
        return False

def diagonal_principal_normal(matriz, i, j, tabela):
    try:
        for off_i in range(4):
            if matriz[i+off_i][j+off_i] != "XMAS"[off_i]:
                return False
        for off_i in range(4):
            tabela[i+off_i][j+off_i] = matriz[i+off_i][j+off_i]
        return True
    except:
        return False

def diagonal_principal_reverso(matriz, i, j, tabela):
    try:
        for off_i in range(4):
            if matriz[i+off_i][j+off_i] != "SAMX"[off_i]:
                return False
        for off_i in range(4):
            tabela[i+off_i][j+off_i] = matriz[i+off_i][j+off_i]
        return True
    except:
        return False

def diagonal_secundaria_normal(matriz, i, j, tabela):
    try:
        for off_i in range(4):
            nj = j-off_i
            if nj < 0:
                return False
            if matriz[i+off_i][j-off_i] != "XMAS"[off_i]:
                return False
        for off_i in range(4):
            tabela[i+off_i][j-off_i] = matriz[i+off_i][j-off_i]
        return True
    except:
        return False

def diagonal_secundaria_reverso(matriz, i, j, tabela):
    try:
        for off_i in range(4):
            nj = j-off_i
            if nj < 0:
                return False
            if matriz[i+off_i][j-off_i] != "SAMX"[off_i]:
                return False
        for off_i in range(4):
            tabela[i+off_i][j-off_i] = matriz[i+off_i][j-off_i]
        return True
    except:
        return False


def printar_tabela(tabela):
    for i in tabela:
        for j in i:
            print(j, end="")
        print("")

def eh_valido(matriz, i, j, tabela):
    testes = [
        na_principal,
        reverso,
        vertical_normal,
        vertical_reverso,
        diagonal_principal_normal,
        diagonal_principal_reverso,
        diagonal_secundaria_normal,
        diagonal_secundaria_reverso,
    ]

    valido_em = 0
    for teste in testes:
        if teste(matriz, i, j, tabela):
            valido_em += 1
    return valido_em

def contar_ocorrencias(matriz):
    tabela = []

    for i in range(len(matriz)):
        linha = []
        for j in range(len(matriz[i])):
            linha.append('.')
        tabela.append(linha)


    ocorrencias = 0
    tamanho = len(matriz)
    for i in range(tamanho):
        for j in range(tamanho):
            ocorrencias += eh_valido(matriz, i, j, tabela)
    # printar_tabela(tabela)
    return ocorrencias

def x_valido(matriz, i, j, tabela):

    res = [
        [
            matriz[i-1][j-1] == "M" and matriz[i+1][j+1] == "S",
            matriz[i-1][j+1] == "M" and matriz[i+1][j-1] == "S",
        ],

        [
            matriz[i-1][j-1] == "S" and matriz[i+1][j+1] == "M",
            matriz[i-1][j+1] == "S" and matriz[i+1][j-1] == "M",
        ],


        [
            matriz[i-1][j-1] == "M" and matriz[i+1][j+1] == "S",
            matriz[i-1][j+1] == "S" and matriz[i+1][j-1] == "M",
        ],

        [
            matriz[i-1][j-1] == "S" and matriz[i+1][j+1] == "M",
            matriz[i-1][j+1] == "M" and matriz[i+1][j-1] == "S",
        ],
    ]

    res = any(list(map(lambda a: all(a), res)))
    if res:
        tabela[i][j] = matriz[i][j]
    return res


def contar_x_de_mas(matriz):
    ret = 0
    tabela = []

    for i in range(len(matriz)):
        linha = []
        for j in range(len(matriz[i])):
            linha.append('.')
        tabela.append(linha)

    tamanho = len(matriz) - 1
    for i in range(1, tamanho):
        for j in range(1, tamanho):
            if matriz[i][j] == "A" and x_valido(matriz, i, j, tabela):
                ret += 1
    # printar_tabela(tabela)
    return ret

# Parte 1
with open("inputs/dia_04_input_01.txt") as f:
    print(contar_ocorrencias(f.read().splitlines()))

# Parte 2
with open("inputs/dia_04_input_01.txt") as f:
    print(contar_x_de_mas(f.read().splitlines()))
