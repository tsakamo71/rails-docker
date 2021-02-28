FROM centos:centos7
 
RUN yum -y update
RUN yum -y install gcc git tar openssl openssl-devel bzip2 readline-devel
 
# rbenvのインストール
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

# node.jsのインストール
RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash -
RUN yum -y install nodejs
 
# rubyのインストール
ENV CONFIGURE_OPTS --disable-install-doc
RUN rbenv install 2.7.2
RUN rbenv global 2.7.2
