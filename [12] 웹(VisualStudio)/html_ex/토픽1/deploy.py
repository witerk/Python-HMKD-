import random
import pandas as pd
import numpy as np
import os
import sklearn


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

device = torch.device('cuda') if torch.cuda.is_available() else torch.device('cpu')

pretrained_model = 'monologg/kobigbird-bert-base'
tokenizer = AutoTokenizer.from_pretrained(pretrained_model)

accuracy = load_metric("accuracy")
def compute_metrics(eval_pred):
    predictions, labels = eval_pred
    predictions = np.argmax(predictions, axis=1)
    return accuracy.compute(predictions=predictions, references=labels)

id2label = {0: "IT과학", 1: "경제", 2: "사회", 3: "생활문화", 4: "세계", 5:"스포츠", 6: "정치" }
label2id = {"IT과학":0, "경제":1, "사회":2, "생활문화":3, "세계":4, "스포츠":5, "정치":6 }

# Load the model
model = AutoModelForSequenceClassification.from_pretrained("topic_model")
model.eval()

def inference_fn(sentence):
  inputs = tokenizer(sentence, truncation=True,  return_token_type_ids=False, return_tensors="pt").to(device)
  model.eval()
  outputs = model(**inputs)
  predictions = outputs.logits.argmax(-1) # argmax(-1)는 마지막 차원(일반적으로 클래스 차원)을 따라 가장 큰 값의 인덱스를 반환
 
  return {
    'sentence': sentence,
    'prediction': id2label[predictions.cpu().numpy()[0]],
  }

  
