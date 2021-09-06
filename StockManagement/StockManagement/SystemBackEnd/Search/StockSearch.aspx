<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="StockSearch.aspx.cs" Inherits="StockManagement.SystemBackEnd.Search.StockSearch" %>

<%@ Register Src="~/UserControls/ucPager.ascx" TagPrefix="uc1" TagName="ucPager" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	
     <link href="../../Content/bootstrap.css" rel="stylesheet" />

    <script src="../../Scripts/bootstrap.js"></script>
    <script src="../../Scripts/bootstrap.bundle.min.js"></script>

    <script src="../../Scripts/customize/fuse.js"></script>
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
    <style>
      #inp{
        width: 34% ;
      }
    
      #tabl{
        width:98% ;margin-left:1%
      }

      tr:nth-child(even){background-color:  #ffecda}

        #ucPagermove {
            margin-left:40%;
            margin-top:5%;
        }

        .shl {
            margin-left:3%;
            margin-top:2%;
        }

        .shb {
            margin-top:2%;
        }
      

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div  id="inp"    class="input-group mb-3">
  <input type="text" class="form-control shl" placeholder="請輸入關鍵字..." aria-label="請輸入關鍵字..." aria-describedby="button-addon2">
  <button class="btn btn-outline-success shb" type="button" id="button-addon2">查詢</button>
</div>

                <div id="tabl" >
                    <table class="table">
                        <thead>
                          <tr class="table-light">
                            <th scope="col">專輯名稱</th>
                            <th scope="col">可用庫存</th>
                            <th scope="col">總庫存</th>
                            <th scope="col">在途</th>
                            <th scope="col">待審核</th>
                            <th scope="col">歌手名稱</th>
                            <th scope="col">發行公司</th>
                            <th scope="col">年份</th>
                            <th scope="col">地區</th>
                         
                          </tr>
                        </thead>
                        <asp:Literal ID="ltlCDStock" runat="server" EnableViewState="false"></asp:Literal>
                        
                      </table>
                     <div id="ucPagermove">
					<uc1:ucPager runat="server" ID="ucPager" Url="StockSearch.aspx"  />
                    </div>
                </div>
            
</asp:Content>
