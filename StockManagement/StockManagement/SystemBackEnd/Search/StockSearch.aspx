<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="StockSearch.aspx.cs" Inherits="StockManagement.SystemBackEnd.Search.StockSearch" %>

<%@ Register Src="~/UserControls/ucPager.ascx" TagPrefix="uc1" TagName="ucPager" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	
    <link href="../../Content/bootstrap.css" rel="stylesheet" />
    <script src="../../Scripts/bootstrap.js"></script>
    <script src="../../Scripts/bootstrap.bundle.min.js"></script>
    <script src="../../Scripts/customize/fuse.js"></script>
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
  <script>
      const Searchjson = '<%=this.Searchjson%>';
      const Searchary = JSON.parse(Searchjson);

	  const options = {
		  includeScore: true,
		  keys: [
			  { name: "Name", weight: 0.4 },
			  { name: "Artist", weight: 0.4 },
			  { name: "Region", weight: 0.1 },
			  { name: "Brand", weight: 0.1 }
		  ]
      }
      const fuse = new Fuse(Searchary, options);

      $(function fuzzySearch() {
		  $('#ContentPlaceHolder1_txtSearch').keyup(function () {
              let result = fuse.search($(this).val())
              $('#dropdownSearch').html('')

              var count = 0;
              for (var data of result) {
				  $('#dropdownSearch').append('<li class="lishow">' + data.item.Name +'</li> ')
                  count++;
                  if (count == 10)
                      break;
              }
          })
      });
 
  </script>
    <style>

      #inp{
        width: 34% ;
      }
    
      #tabl{
        width:98% ;margin-left:1%;margin-top:1.5%;margin-right:1%;
   
      }

      tr:nth-child(even){background-color:  #ffecda}

        #ucPagermove {
            margin-left:40%;
            margin-top:3.5%;
        }

        .shl {
            margin-left:3%;
            margin-top:2%;
        }

        .shb {
            margin-top:2%;
        }

        #showall {
            height:38.5px;
            margin-top:-0.1%;
            margin-bottom:0.1%;
            margin-left:0.8%;
           
            }

        #ContentPlaceHolder1_txtSearch {
             height:37.5px;
             width:325px;
             margin-left:0.79%;
             margin-top:1.1%;
 
           
      
        }
        #ContentPlaceHolder1_btnSearch {
             height:38.5px;
             margin-top:-0.1%;
             margin-bottom:0.1%;
             margin-left:0.5%;
             width:70px;
        }


        #CDN {
            text-align:left;
        }
      
        
        #tdlist {
             text-align:center;
             padding-right:2.7%;
             padding-left:1%;
        }
        #dropdownSearch {
            width:325px;
            
          
            

        }

        .lishow:hover {
           background-color:rgb(208 208 208 / 0.54);
           
        }

        .lishow {
            margin-left:1%;
            margin-right:1%;
            padding-top:5%;
            padding-bottom:5%;
            padding-left:4%;
            padding-right:5%;
            
            list-style-position: outside;
        }

        .form-control {
        display:inline;
       
        }

  


    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    


     <div>
        <div class="dropdown  ">
             
            <asp:TextBox ID="txtSearch" runat="server" CssClass="dropdown-toggle form-control" class="form-inline"  placeholder="請輸入關鍵字..." aria-label="Recipient's username" ></asp:TextBox>
            <ul class="dropdown-menu" id="dropdownSearch">
             <li></li>
             <li>a</li>
             <li>b</li>
             <li>c</li>
            </ul>
         
            <asp:Button ID="btnSearch" runat="server" Text="查詢" CssClass="btn btn-outline-success"   OnClientClick="btnSearchClick()" />
             
           <a id="showall" class="btn btn-outline-success" href="StockSearch.aspx" role="button">顯示全部</a>
                
            <%-- FuzzySearch的結果的HiddenField --%>
            <asp:HiddenField ID="HFSearchResult" runat="server" />

        </div>
    </div>
    
                <div id="tabl" >
                    <table class="table">
                        <thead>
                          <tr  class="table-light">
                            <th scope="col" >專輯名稱</th>
                            <th scope="col" >可用庫存</th>
                            <th scope="col" >總庫存</th>
                            <th scope="col" >在途庫存</th>
                            <th scope="col" >待審核</th>
                            <th scope="col" >歌手名稱</th>
                            <th scope="col">發行公司</th>
                            <th scope="col"id="threg">地區</th>
                            <th scope="col">年份</th>
                           
                         
                          </tr>
                        </thead>
                        <asp:Literal ID="ltlCDStock" runat="server" EnableViewState="false"></asp:Literal>
                        
                      </table>
                 </div>
                     
                
                     <div id="ucPagermove">
					<uc1:ucPager runat="server" ID="ucPager" Url="StockSearch.aspx"  />
                     </div>
                   
            
</asp:Content>
