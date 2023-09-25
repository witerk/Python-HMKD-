import random
import pandas as pd
import numpy as np
import os

from sklearn.model_selection import train_test_split
# from sklearn.feature_extraction.text import TfidfVectorizer # baseline code용 tfidef vectorirzer(또는 tokenizer)
from sklearn import preprocessing
from sklearn.metrics import f1_score
# from IPython.display import display, HTML

from transformers import AutoModel, AutoTokenizer,AutoModelForSequenceClassification, TrainingArguments, Trainer # 사용하고자 하는 모델, 토크나이저 적용시 필요
import torch
import torch.nn as nn
import torch.optim as optim
import torch.nn.functional as F
from torch.utils.data import Dataset, DataLoader
from datasets import load_dataset, ClassLabel, load_metric

from tqdm.auto import tqdm # process bar 표시용

import warnings
warnings.filterwarnings(action='ignore')

import urllib.request
import evaluate

# ------------------------------------------------------------

device = torch.device('cuda') if torch.cuda.is_available() else torch.device('cpu')

accuracy = load_metric("accuracy")

pretrained_model = 'klue/roberta-small'
tokenizer = AutoTokenizer.from_pretrained(pretrained_model)

# 주어진 모델 평가 결과를 기반으로 정확도를 계산
def compute_metrics(eval_pred):
  predictions, labels = eval_pred
  predictions = np.argmax(predictions, axis=1)
  return accuracy.compute(predictions = predictions, references=labels)

# 라벨과 인덱스 사이의 매핑을 제공하는 딕셔너리 정의
id2label = {0:"부정", 1:"긍정"}
label2id = {"부정":0, "긍정":1}

model = AutoModelForSequenceClassification.from_pretrained("my_model")
model.eval()

def inference_fn(sentence):
  inputs = tokenizer(
      [sentence],
      max_length=20,
      padding='max_length',
      truncation=True,
  )

  with torch.no_grad():
    outputs = model(**{k:torch.tensor(v) for k, v in inputs.items()})
    prob = outputs.logits.softmax(dim=1)
    positive_prob = round(prob[0][1].item(), 4)
    negative_prob = round(prob[0][0].item(), 4)
    pred = '긍정(positive)' if torch.argmax(prob) == 1 else '부정(nagative)'

  return {
    'sentence':sentence,
    'prediction':pred,
    'positive_data':f'긍정 {positive_prob}',
    'negative_data':f'긍정 {negative_prob}',
    'positive_width':f'{positive_prob*100}%',
    'negative_width':f'{round(negative_prob*100, 2)}%',
  }