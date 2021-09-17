<%@ Page Title="薛丁格-庫存查詢" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="StockSearch.aspx.cs" Inherits="StockManagement.SystemBackEnd.Search.StockSearch" %>

<%@ Register Src="~/UserControls/ucPager.ascx" TagPrefix="uc1" TagName="ucPager" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	
    
    <link href="../../Content/bootstrap.css" rel="stylesheet" />
    <script src="../../Scripts/bootstrap.js"></script>
    <script src="../../Scripts/bootstrap.bundle.min.js"></script>
    <script src="../../Scripts/customize/fuse.js"></script>
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
    <link href="../../StyleSheet/StockSearchStyle.css" rel="stylesheet" />
  <script>
      const Searchjson = '<%=this.Searchjson%>';
      const Searchary = JSON.parse(Searchjson);

	  const options = {
		  includeScore: true,
		  keys: [
			  { name: "Name", weight:100 },
			  { name: "Artist", weight: 50 },
			  { name: "Region", weight: 0.05},
			  { name: "Brand", weight: 0.05 }
		  ]
      }
      const fuse = new Fuse(Searchary, options);

      function fuseSearch(pattern) {
          let result = fuse.search(pattern);
          $('#dropdownSearch').html('')

          var count = 0;
          for (var data of result) {
              $('#dropdownSearch').append('<li class="lishow">' + data.item.Name + '</li> ')
              count++;
              if (count == 10)
                  break;
          }
          return result;
      }

      $(function () {
          $('#ContentPlaceHolder1_txtSearch').keyup(function () {
              fuseSearch($(this).val())
          })

          //搜尋紐事件 //asp控制項會改ID 改成後臺可讀取語言 搜尋結果放入HF
          $('input[id$=btnSearch]').click(function () {
			  let result = fuse.search($('input[id$=txtSearch]').val());

			  $('input[id$=btnhappenhf]').val(JSON.stringify(result));
              
          })

          $('#dropdownSearch').on('click','li',function(){

              $('#ContentPlaceHolder1_txtSearch').val($(this).text());
              fuseSearch($('#ContentPlaceHolder1_txtSearch').val());
          })

      });
 
  </script>
    <style>
       

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    


     <div>
        <div class="dropdown">
             
            <asp:TextBox ID="txtSearch" runat="server" CssClass="dropdown-toggle form-control"   placeholder="請輸入關鍵字..." aria-label="Recipient's username" ></asp:TextBox>
            <ul class="dropdown-menu" id="dropdownSearch">
                
            </ul>

            <asp:HiddenField ID="btnhappenhf" runat="server" />

            <asp:Button ID="btnSearch" runat="server" Text="查詢" CssClass="btn btn-outline-success"   OnClientClick="btnSearchClick()" />
             
           <a id="showall" class="btn btn-outline-primary" href="StockSearch.aspx" role="button">顯示全部</a>
                
           


        </div>
    </div>
    
                <div id="tabl">
                    <table class="table" >
                        <thead>
                          <tr  class="table-light">
                            <th scope="col" >專輯名稱</th>
                            <th scope="col" >可用庫存</th>
                            <th scope="col" >總庫存</th>
                            <th scope="col" >在途庫存</th>
                            <th scope="col" >歌手名稱</th>
                            <th scope="col">發行公司</th>
                            <th scope="col"id="threg">地區</th>
                            <th scope="col">年份</th>
                           
                         
                          </tr>
                        </thead>
                        <asp:Literal ID="ltlCDStock" runat="server" EnableViewState="false"></asp:Literal>
                        
                      </table>
                    <div id="norecen">
                         <asp:Label ID="nore" runat="server" Text=""></asp:Label>
                    </div>
                   
                 </div>
                    
                     <div id="ucPagermove">
					<uc1:ucPager runat="server" ID="ucPager" Url="StockSearch.aspx"  />
                        
                     </div>
                   
            
</asp:Content>
