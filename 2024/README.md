# Homepage Project

![AWS drawio](https://github.com/user-attachments/assets/a571e6e6-4d1c-4fae-8180-3a25f0ce85c0)

自分のWebページを構成するプロジェクトです。インフラ部分としてはAWSと自宅サーバーを用いて構成しようと考えており、上の構成となることを目指して作成します。

このレポジトリから使用する技術は以下の通りです。

-   AWSのサービス
-   Terraform
-   Ansible (nginx, wireguard)

# NOTE

AWSは無料利用枠を最大限活用しているので現在は月1500円程度ですが、最終的には、自宅サーバーからこれらの機能を直接公開できるようにできればと考えています。
無料枠が切れそうなので、停止しました。
DigitalOceanに移行予定です。

## 管理マシンの準備

IaCのコード管理はMacOSのマシンで行います。

```shell
brew update
brew install terraform
brew install ansible
```

## AWSの準備

個人用のAWSアカウントを想定します。Terraformで管理できる部分と、
手動で行った方が良い部分があるので、特に手動の部分を準備しておきます。

1. AWSアカウントの作成

はじめに作成されるAWSアカウントはrootユーザーでどのような権限も持っているので、普段操作用のIAMユーザーを作成します。

2. IAMユーザーの作成

IAMユーザーを作成する際に、グループ、ポリシーなどを設定する必要があり、
個人管理を想定しているため、AdministratorAccessのポリシーを追加します。
これで普段の管理はこのIAMユーザーで完結するはずです。

3. 独自ドメインの取得

お名前.comなどでも良いと思いますが、今回はAWSにまとめたかったのでRoute 53を用いて独自ドメインを入手しました。
この時に使用されるName Serverの名前を記録しておきます。

4. Route 53のホストゾーンの設定

もしTerraformでホストゾーンの設定をし、それを対応させようとするとホストゾーンの作成時に割り当てられる
Name Serverが取得したドメインのものと異なり、エラーが起きてしまうようです。
そこで、ホストゾーンの設定のみ手動でで行い、TerraformからはIDからこのホストゾーンにアクセスできるようにします。
ホストゾーンのIDは、terraform/terraform.tfvarsに入力しておきます。

## インフラ部分の準備

まず、terraformでインフラ構成を行います。wireguardやnginxは後でAnsibleを用いて設定します。
EC2にSSHアクセスするための鍵をあらかじめ作成しておきます。

```shell
mkdir ~/.ssh
cd ~/.ssh
ssh-keygen -t ed25519
```

この時生成される公開鍵、**id_ed25519.pub**のパスをterraform/terraform.tfvarsに入力しておきます。

細かな設定後、以下のコマンドで図で表したインフラが整備されます。

```shell
cd terraform
terraform init
terraform plan -out=./planxxx
terraform apply "./planxxx"
```

## ミドルウェアの準備

Ansibleを用いて、インストールを行います。細かな設定はファイルを参照してください。

```shell
cd ..
cd ansible
ansible-playbook playbook.yml
```
