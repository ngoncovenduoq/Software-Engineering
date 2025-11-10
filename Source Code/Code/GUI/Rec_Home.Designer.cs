namespace Project_CNPM
{
    partial class Rec_Home
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.panelChildForm1 = new System.Windows.Forms.Panel();
            this.btnCheck = new Guna.UI2.WinForms.Guna2GradientTileButton();
            this.btnList = new Guna.UI2.WinForms.Guna2GradientTileButton();
            this.panelChildForm1.SuspendLayout();
            this.SuspendLayout();
            // 
            // panelChildForm1
            // 
            this.panelChildForm1.AutoScroll = true;
            this.panelChildForm1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(241)))), ((int)(((byte)(241)))), ((int)(((byte)(241)))));
            this.panelChildForm1.Controls.Add(this.btnCheck);
            this.panelChildForm1.Controls.Add(this.btnList);
            this.panelChildForm1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panelChildForm1.Location = new System.Drawing.Point(0, 0);
            this.panelChildForm1.Name = "panelChildForm1";
            this.panelChildForm1.Size = new System.Drawing.Size(1116, 731);
            this.panelChildForm1.TabIndex = 10;
            // 
            // btnCheck
            // 
            this.btnCheck.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.btnCheck.BorderRadius = 5;
            this.btnCheck.BorderStyle = System.Drawing.Drawing2D.DashStyle.DashDot;
            this.btnCheck.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnCheck.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnCheck.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnCheck.DisabledState.FillColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnCheck.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnCheck.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(63)))), ((int)(((byte)(220)))), ((int)(((byte)(254)))));
            this.btnCheck.FillColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(63)))), ((int)(((byte)(220)))), ((int)(((byte)(254)))));
            this.btnCheck.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCheck.ForeColor = System.Drawing.Color.White;
            this.btnCheck.GradientMode = System.Drawing.Drawing2D.LinearGradientMode.Vertical;
            this.btnCheck.Image = global::Project_CNPM.Properties.Resources.tnbn;
            this.btnCheck.ImageOffset = new System.Drawing.Point(0, 30);
            this.btnCheck.ImageSize = new System.Drawing.Size(200, 130);
            this.btnCheck.Location = new System.Drawing.Point(98, 73);
            this.btnCheck.Name = "btnCheck";
            this.btnCheck.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.btnCheck.ShadowDecoration.Color = System.Drawing.Color.DimGray;
            this.btnCheck.Size = new System.Drawing.Size(920, 260);
            this.btnCheck.TabIndex = 22;
            this.btnCheck.Text = "TIẾP NHẬN BỆNH NHÂN";
            this.btnCheck.TextOffset = new System.Drawing.Point(0, 20);
            this.btnCheck.Click += new System.EventHandler(this.btnCheck_Click);
            // 
            // btnList
            // 
            this.btnList.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.btnList.BorderRadius = 5;
            this.btnList.BorderStyle = System.Drawing.Drawing2D.DashStyle.DashDot;
            this.btnList.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnList.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnList.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnList.DisabledState.FillColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnList.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnList.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(63)))), ((int)(((byte)(220)))), ((int)(((byte)(254)))));
            this.btnList.FillColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(63)))), ((int)(((byte)(220)))), ((int)(((byte)(254)))));
            this.btnList.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnList.ForeColor = System.Drawing.Color.White;
            this.btnList.GradientMode = System.Drawing.Drawing2D.LinearGradientMode.Vertical;
            this.btnList.Image = global::Project_CNPM.Properties.Resources.dsbn;
            this.btnList.ImageOffset = new System.Drawing.Point(0, 30);
            this.btnList.ImageSize = new System.Drawing.Size(200, 130);
            this.btnList.Location = new System.Drawing.Point(98, 384);
            this.btnList.Name = "btnList";
            this.btnList.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.btnList.ShadowDecoration.Color = System.Drawing.Color.DimGray;
            this.btnList.Size = new System.Drawing.Size(920, 260);
            this.btnList.TabIndex = 21;
            this.btnList.Text = "DANH SÁCH TIẾP NHẬN BỆNH NHÂN";
            this.btnList.TextOffset = new System.Drawing.Point(0, 20);
            this.btnList.Click += new System.EventHandler(this.btnList_Click);
            // 
            // Rec_Home
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1116, 731);
            this.Controls.Add(this.panelChildForm1);
            this.Name = "Rec_Home";
            this.Text = "Rec_Home";
            this.panelChildForm1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panelChildForm1;
        private Guna.UI2.WinForms.Guna2GradientTileButton btnList;
        private Guna.UI2.WinForms.Guna2GradientTileButton btnCheck;
    }
}