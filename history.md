## Exo 1

Deploy:

```bash
$ nile compile contracts/token/ERC721/ERC721.cairo
$ name=$(python -c "print(''.join(str(ord(str(c))) for c in 'tests-erc721'))")
$ symbol=$(python -c "print(''.join(str(ord(str(c))) for c in 'T721'))")
$ evaluator_addr=0x03b56add608787daa56932f92c6afbeb50efdd78d63610d9a904aae351b6de73
$ nile deploy ERC721 $name $symbol $evaluator_addr --network goerli
```

```python
🚀 Deploying ERC721
⏳ ️Deployment of ERC721 successfully sent at 0x0763f38ca5138333f6fe7d7d8c1988f925a2e93310dcd6e95395b01e3e0086ef
🧾 Transaction hash: 0x523f9fcf7f1d047f76264ea76abbe25f80488dd11e5f84494e5f366e95bd192
📦 Registering 0x0763f38ca5138333f6fe7d7d8c1988f925a2e93310dcd6e95395b01e3e0086ef in goerli.deployments.txt
```

Then, interact on https://goerli.voyager.online.

## Exo 2

Deploy:

```bash
$ nile compile contracts/token/ERC721/ERC721.cairo
$ name=$(python -c "print(''.join(str(ord(str(c))) for c in 'tests-erc721-2'))")
$ symbol=$(python -c "print(''.join(str(ord(str(c))) for c in 'T721-2'))")
$ evaluator_addr=0x03b56add608787daa56932f92c6afbeb50efdd78d63610d9a904aae351b6de73
$ nile deploy ERC721 $name $symbol $evaluator_addr --network goerli
```

```python
🚀 Deploying ERC721
⏳ ️Deployment of ERC721 successfully sent at 0x07ac563634e99cdcfce9b7dc53bbf9906e491d20bb00cbefc4d174a056f7f1ef
🧾 Transaction hash: 0x797eb5b49f41f6ea3f230612135f88545722906a0c77b0be0810f01a9322a3d
📦 Registering 0x07ac563634e99cdcfce9b7dc53bbf9906e491d20bb00cbefc4d174a056f7f1ef in goerli.deployments.txt
```

Then, interact on https://goerli.voyager.online.

## Exo 3

Deploy:

```bash
$ nile compile contracts/token/ERC721/ERC721.cairo
$ name=$(python -c "print(''.join(str(ord(str(c))) for c in 'tests-erc721-3'))")
$ symbol=$(python -c "print(''.join(str(ord(str(c))) for c in 'T721-2'))")
$ evaluator_addr=0x03b56add608787daa56932f92c6afbeb50efdd78d63610d9a904aae351b6de73
$ nile deploy ERC721 $name $symbol $evaluator_addr --network goerli
```

```python
🚀 Deploying ERC721
⏳ ️Deployment of ERC721 successfully sent at 0x018f99e7b55e233a701a975e762e5c23045772b0df2182335825394bca655d42
🧾 Transaction hash: 0x4e303cc6c8660246818e96e1c597fc39348797462c65c8c1ebbb8a765368076
📦 Registering 0x018f99e7b55e233a701a975e762e5c23045772b0df2182335825394bca655d42 in goerli.deployments.txt
```

Then, interact on https://goerli.voyager.online.
