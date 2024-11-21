import wave
import sys

def main(argv):
    if len(argv) < 2:
        print("Uso: python script.py <caminho_para_ficheiro_wave>")
        return

    # Abrir o ficheiro WAVE em modo de leitura binária
    with wave.open(argv[1], "rb") as wf:
        # Obter o número de canais
        num_canais = wf.getnchannels()
        # Obter a frequência de amostragem (Sample Rate)
        frequencia_amostragem = wf.getframerate()
        # Obter o tamanho de cada Sample
        tamanho_sample = wf.getsampwidth()
        # Obter o número de Frames
        num_frames = wf.getnframes()

        # Imprimir a informação obtida
        print(f"Número de Canais: {num_canais}")
        print(f"Frequência de Amostragem: {frequencia_amostragem} Hz")
        print(f"Tamanho de Cada Sample: {tamanho_sample} bytes")
        print(f"Número de Frames: {num_frames}")

if __name__ == "__main__":
    main(sys.argv)
