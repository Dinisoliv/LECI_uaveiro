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
import wave
import sys
import pyaudio

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

        # Configuração do PyAudio para reprodução do som
        player = pyaudio.PyAudio()

        # Modificar a variável frame_rate para experimentar diferentes velocidades
        # frame_rate_modificado = frequencia_amostragem * 2  # Exemplo: duplicar a velocidade
        frame_rate_modificado = frequencia_amostragem  # Manter a velocidade original

        stream = player.open(
            format=player.get_format_from_width(tamanho_sample),
            channels=num_canais,
            rate=frame_rate_modificado,
            output=True
        )

        # Reproduzir o som
        while True:
            data = wf.readframes(1024)
            if not data:
                break
            stream.write(data)

        # Fechar o stream e o player
        stream.close()
        player.terminate()

if __name__ == "__main__":
    main(sys.argv)
