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
