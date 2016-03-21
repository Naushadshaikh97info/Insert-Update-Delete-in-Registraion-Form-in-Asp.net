using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class registraion_form : System.Web.UI.Page
{
    DataClassesDataContext linq_obj = new DataClassesDataContext();
    static string fhoto_nm;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
            return;
        fill_registraion();
        fill_country();
    }
    private void fill_registraion()
    {
        var id = (from a in linq_obj.registraion_msts
                  join b in linq_obj.country_msts on a.country equals b.intglcode
                  join c in linq_obj.state_msts on a.state equals c.intglcode
                  select new
                  {
                      code = a.intglcode,
                      FirstName = a.firstname,
                      LastName = a.lastname,
                      Emailid = a.emailid,
                      MobileNo = a.mobileno,
                      Gender = a.gender,
                      Country = b.country,
                      State = c.state,
                      Hobbies = a.hobbies,
                      fhoto_nm = "./upload/" + a.image
                  }).ToList();
        GridView1.DataSource = id;
        GridView1.DataBind();
    }
    private void fill_country()
    {
        var id = (from a in linq_obj.country_msts
                  select a).ToList();
        ddl_country.DataSource = id;
        ddl_country.DataBind();
        ddl_country.Items.Insert(0,"-- Select Country --");
    }
    private void fill_state()
    {
        var id = (from a in linq_obj.state_msts
                  where a.country_id == Convert.ToInt32(ddl_country.SelectedValue)
                  select a).ToList();
        ddl_state.DataSource = id;
        ddl_state.DataBind();
        ddl_state.Items.Insert(0,"-- Select State --");
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        if (FileUpload1.PostedFile.FileName != "")
        {
            FileUpload1.SaveAs(Request.PhysicalApplicationPath + "/upload/" + FileUpload1.FileName);
            fhoto_nm = FileUpload1.FileName;
        }

        string hobbies = "";
        for (int i = 0; i < ch_hobbies.Items.Count; i++)
        {
            if (ch_hobbies.Items[i].Selected)
            {
                if (hobbies == "")
                {
                    hobbies = ch_hobbies.Items[i].Value;
                }
                else
                {
                    hobbies += "," + ch_hobbies.Items[i].Value;
                }
            }
        }

        linq_obj.insert_registraion(txt_firstname.Text, txt_LastName.Text, txt_emailid.Text, txt_mobileno.Text, rb_gender.SelectedItem.Text, Convert.ToInt32(ddl_country.SelectedValue), Convert.ToInt32(ddl_state.SelectedValue), hobbies, fhoto_nm);
        linq_obj.SubmitChanges();
        fill_registraion();
        ClientScript.RegisterStartupScript(this.GetType(), "Success", "<script type='text/javascript'>alert('** Thanks For Registration **');window.location='registraion_form.aspx';</script>'");
    }
    protected void btn_update_Click(object sender, EventArgs e)
    {
        if (FileUpload1.PostedFile.FileName != "")
        {
            FileUpload1.SaveAs(Request.PhysicalApplicationPath + "/upload/" + FileUpload1.FileName);
            fhoto_nm = FileUpload1.FileName;
        }

        string hobbies = "";
        for (int i = 0; i < ch_hobbies.Items.Count; i++)
        {
            if (ch_hobbies.Items[i].Selected)
            {
                if (hobbies == "")
                {
                    hobbies = ch_hobbies.Items[i].Value;
                }
                else
                {
                    hobbies += "," + ch_hobbies.Items[i].Value;
                }
            }
        }

        linq_obj.update_registraion(Convert.ToInt32(ViewState["code"].ToString()), txt_firstname.Text, txt_LastName.Text, txt_emailid.Text, txt_mobileno.Text, rb_gender.SelectedItem.Text, Convert.ToInt32(ddl_country.SelectedValue), Convert.ToInt32(ddl_state.SelectedValue), hobbies, fhoto_nm);
        linq_obj.SubmitChanges();
        fill_registraion();
        ClientScript.RegisterStartupScript(this.GetType(), "Success", "<script type='text/javascript'>alert('** Update Successfully **');window.location='registraion_form.aspx';</script>'");
    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        linq_obj.delete_registraion(Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString()));
        linq_obj.SubmitChanges();
        fill_registraion();
        Page.RegisterStartupScript("onload", "<script language='javascript'>alert('** Delete Successfully **')</script>");
    }
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            int code = Convert.ToInt32(GridView1.DataKeys[e.NewEditIndex].Value.ToString());
            ViewState["code"] = code;
            var id = (from a in linq_obj.registraion_msts
                      where a.intglcode == code
                      select a).Single();

            txt_emailid.Text = id.emailid;
            txt_firstname.Text = id.firstname;
            txt_LastName.Text = id.lastname;
            txt_mobileno.Text = id.mobileno;
            ddl_country.SelectedValue = id.country.ToString();
            ddl_state.SelectedValue = id.state.ToString();
            fill_state();
            rb_gender.SelectedValue = id.gender;
            fhoto_nm = id.image;

            string[] abc = id.hobbies.Split(',');
            for (int i = 0; i < abc.Length; i++)
            {
                string xyz = abc[i].ToString();
                for (int j = 0; j < ch_hobbies.Items.Count; j++)
                {
                    if (ch_hobbies.Items[j].Value == xyz)
                    {
                        ch_hobbies.Items[j].Selected = true;
                    }
                }
            }

            btn_submit.Visible = false;
            btn_update.Visible = true;
        }
        catch (Exception)
        {
            
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        fill_registraion();
    }
    protected void ddl_country_SelectedIndexChanged(object sender, EventArgs e)
    {
        fill_state();
    }
    protected void valInquiry_ServerValidation(object source, ServerValidateEventArgs args)
    {
        args.IsValid = ch_hobbies.SelectedItem != null;
    }
}