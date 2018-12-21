# mnist
mnist example with pytorch (and maybe other frameworks) from zero to production

## run

```
docker run -it --rm -p 63832:8888 -v $(pwd)/notebooks:/root/hostbooks pandorasnox/deepo:pytorch-py36-jupyter-cpu jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/root'

docker run -d -t --rm --name pandorasnox_mnist -p 63832:8888 -v $(pwd):/workspace -w "/workspace" pandorasnox/deepo:pytorch-py36-jupyter-cpu


# status ?!
docker ps --filter "name=pandorasnox_mnist" | tail -n 1 | awk '{print $1}'

```

`pip install flair`

- pocket science lab
