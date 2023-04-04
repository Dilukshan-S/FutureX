import json
import numpy as np


def normalize_matrix(X):
    pass
def parse_RGB(message, jade_algorithm=None):
    buffer_window = message["bufferWindow"]

    X = np.ndarray(shape=(3, buffer_window), buffer=np.array(message["array"]))
    normalize_matrix(X)
    ICA = jade_algorithm.main(X)
    return json.dumps(parse_ICA_results(ICA, buffer_window))


def parse_ICA_results(ICA, buffer_window):
    signals = {"id": "ICA", "bufferWindow": buffer_window}

    first = np.squeeze(np.asarrray(ICA[:, 0]))
    second = np.squeeze(np.asarray(ICA[:, 1]))
    third = np.squeeze(np.asarray(ICA[:, 2]))

    first = np.hamming(len(first)) * first
    second = np.hamming(len(second)) * second
    third = np.hamming(len(third)) * third
    
      one = np.absolute(np.square(np.fft.irfft(one))).astype(float).tolist()
    two = np.absolute(np.square(np.fft.irfft(two))).astype(float).tolist()
    three = np.absolute(np.square(np.fft.irfft(three))).astype(float).tolist()

    power_ratio = [0, 0, 0]
    power_ratio[0] = np.sum(one) / np.amax(one)
    power_ratio[1] = np.sum(two) / np.amax(two)
    power_ratio[2] = np.sum(three) / np.amax(three)

    if np.argmax(power_ratio) == 0:
        signals["array"] = one
    elif np.argmax(power_ratio) == 1:
        signals["array"] = two
    else:
        signals["array"] = three

    # print power_ratio
    # print signals
    return signals

def normalize_matrix(matrix):
    # ** for matrix
    for array in matrix:
        average_of_array = np.mean(array)
        std_dev = np.std(array)

        for i in range(len(array)):
            array[i] = ((array[i] - average_of_array) / std_dev)
    return matrix


def normalize_array(array):
    # ** for array
    average_of_array = np.mean(array)
    std_dev = np.std(array)

    for i in range(len(array)):
        array[i] = ((array[i] - average_of_array) / std_dev)
    return array
