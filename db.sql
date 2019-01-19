create table ListCategory
(
  Name        varchar(50) not null,
  Description varchar(50) null,
  Image       varchar(70) null,
  constraint ListCategory_Name_uindex
  unique (Name)
);

alter table ListCategory
  add primary key (Name);

create table ProductCategory
(
  Name        varchar(50) not null,
  Description varchar(50) null,
  Image       varchar(50) null,
  constraint ProductCategory_Name_uindex
  unique (Name)
);

alter table ProductCategory
  add primary key (Name);

create table Product
(
  Name        varchar(50)  not null,
  CatName     varchar(50)  not null,
  Description varchar(100) null,
  Image       varchar(70)  null,
  Logo        varchar(70)  null,
  primary key (Name, CatName),
  constraint Product_ProductCategory_Name_fk
  foreign key (CatName) references ProductCategory (Name)
);

create table ProductCat_ListCat
(
  ListCatName    varchar(50) default '' not null,
  ProductCatName varchar(50) default '' not null,
  primary key (ListCatName, ProductCatName),
  constraint ProductCat_ListCat_ListCategory_Name_fk
  foreign key (ListCatName) references ListCategory (Name),
  constraint ProductCat_ListCat_ProductCategory_Name_fk
  foreign key (ProductCatName) references ProductCategory (Name)
);

create table User
(
  Email     varchar(50) not null,
  Password  varchar(50) not null,
  FirstName varchar(50) not null,
  LastName  varchar(50) not null,
  Image     varchar(70) null,
  Typology  varchar(50) not null,
  Valid     tinyint(1)  null,
  Cod       varchar(50) null,
  Cookie    varchar(36) null,
  constraint User_Email_uindex
  unique (Email)
);

alter table User
  add primary key (Email);

create table List
(
  Name        varchar(50)  not null,
  CatName     varchar(50)  not null,
  Description varchar(100) null,
  Image       varchar(70)  null,
  OwnerEmail  varchar(50)  not null,
  primary key (Name, CatName),
  constraint List_ListCategory_Name_fk
  foreign key (CatName) references ListCategory (Name),
  constraint List_User_Email_fk
  foreign key (OwnerEmail) references User (Email)
);

create table List_Product
(
  ListName    varchar(50) not null,
  ProductName varchar(50) not null,
  primary key (ListName, ProductName),
  constraint List_Product_List_Name_fk
  foreign key (ListName) references List (Name),
  constraint List_Product_Product_Name_fk
  foreign key (ProductName) references Product (Name)
);

