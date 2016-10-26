package br.com.silvaesouza.cucumbersample.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name="TBL_TEST_TA")
@SequenceGenerator(name = "sequence_ta", sequenceName = "SEQ_TA")
public class TA implements Serializable {
	
	private static final long serialVersionUID = 1L;

    private Integer tqaCodigo;
    private Date tqaDataCriacao;
    private Integer tqaSomaVoz;
    /*private Integer tqaSomaTransmissao;
    private Integer tqaSomaDeterministica;
    private Integer tqaSomaSpeedy;
    private Integer tqaSomaCliente;
    private Integer tqaSomaCp;
    private Integer tqaSomaRedeip;
    private Integer tqaSomaInterconexao;
    private Integer tqaSomaSppac;
    private Integer tqaSomaDth;
    private Integer tqaSomaFttx;
    private Integer tqaSomaIptv;*/
    
    private TA ta;
    private TaAfetacaoParcial taAfetacaoParcial;
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="TQA_ULTIMA_AFETACAO")
    @org.hibernate.annotations.ForeignKey( name = "none") 
    public TaAfetacaoParcial getTaAfetacaoParcial() {
        return this.taAfetacaoParcial;
    }
    
	public void setTaAfetacaoParcial(TaAfetacaoParcial taAfetacaoParcial) {
		this.taAfetacaoParcial = taAfetacaoParcial;
	}

	@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="TQA_RAIZ")
	@org.hibernate.annotations.ForeignKey( name = "none") 
    public TA getTa() {
        return this.ta;
    }
	
	public void setTa(TA ta) {
		this.ta = ta;
	}
    
    @Id 
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "sequence_ta")
    @Column(name="TQA_CODIGO", nullable=false, precision=10, scale=0)
    public Integer getTqaCodigo() {
        return this.tqaCodigo;
    }
    
    public void setTqaCodigo(Integer tqaCodigo) {
        this.tqaCodigo = tqaCodigo;
    }
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="TQA_DATA_CRIACAO", nullable=false, length=7)
    public Date getTqaDataCriacao() {
        return this.tqaDataCriacao;
    }
    
    public void setTqaDataCriacao(Date tqaDataCriacao) {
        this.tqaDataCriacao = tqaDataCriacao;
    }

    @Column(name="TQA_SOMA_VOZ", nullable=false, precision=10, scale=0)
    public Integer getTqaSomaVoz() {
        return this.tqaSomaVoz;
    }
    
    public void setTqaSomaVoz(Integer tqaSomaVoz) {
        this.tqaSomaVoz = tqaSomaVoz;
    }
}
