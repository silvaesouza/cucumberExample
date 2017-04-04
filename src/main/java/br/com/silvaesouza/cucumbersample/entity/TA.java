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
@Table(name="TBL_TA")
@SequenceGenerator(name = "sequence_ta", sequenceName = "SEQ_TA")
public class TA implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "sequence_ta")
    @Column(name="TQA_CODIGO", nullable=false, precision=10, scale=0)
    private Integer tqaCodigo;

	@Temporal(TemporalType.TIMESTAMP)
    @Column(name="TQA_DATA_CRIACAO", nullable=false, length=7)
    private Date tqaDataCriacao;

	@Column(name="TQA_SOMA_VOZ", nullable=false, precision=10, scale=0)
    private Integer tqaSomaVoz;

	@Column(name="TQA_SOMA_TRANSMISSAO", precision=10, scale=0)
    private Integer tqaSomaTransmissao;

	@Column(name="TQA_SOMA_DETERMINISTICA", precision=10, scale=0)
    private Integer tqaSomaDeterministica;

	@Column(name="TQA_SOMA_SPEEDY", precision=10, scale=0)
    private Integer tqaSomaSpeedy;

	@Column(name="TQA_SOMA_CLIENTE", precision=10, scale=0)
	private Integer tqaSomaCliente;

	@Column(name="TQA_SOMA_CP", precision=10, scale=0)
    private Integer tqaSomaCp;

	@Column(name="TQA_SOMA_REDEIP", precision=10, scale=0)
    private Integer tqaSomaRedeip;

	@Column(name="TQA_SOMA_INTERCONEXAO", precision=10, scale=0)
    private Integer tqaSomaInterconexao;

	@Column(name="TQA_SOMA_SPPAC", precision=10, scale=0)
    private Integer tqaSomaSppac;

	@Column(name="TQA_SOMA_DTH", precision=10, scale=0)
    private Integer tqaSomaDth;

	@Column(name="TQA_SOMA_FTTX", precision=10, scale=0)
    private Integer tqaSomaFttx;

	@Column(name="TQA_SOMA_IPTV", precision=10, scale=0)
    private Integer tqaSomaIptv;

	@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="TQA_RAIZ")
	@org.hibernate.annotations.ForeignKey( name = "none")
    private TA ta;

	@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="TQA_ULTIMA_AFETACAO")
    @org.hibernate.annotations.ForeignKey( name = "none")
    private TaAfetacaoParcial taAfetacaoParcial;

    public TaAfetacaoParcial getTaAfetacaoParcial() {
        return this.taAfetacaoParcial;
    }

	public void setTaAfetacaoParcial(TaAfetacaoParcial taAfetacaoParcial) {
		this.taAfetacaoParcial = taAfetacaoParcial;
	}

    public TA getTa() {
        return this.ta;
    }

	public void setTa(TA ta) {
		this.ta = ta;
	}

    public Integer getTqaCodigo() {
        return this.tqaCodigo;
    }

    public void setTqaCodigo(Integer tqaCodigo) {
        this.tqaCodigo = tqaCodigo;
    }

    public Date getTqaDataCriacao() {
        return this.tqaDataCriacao;
    }

    public void setTqaDataCriacao(Date tqaDataCriacao) {
        this.tqaDataCriacao = tqaDataCriacao;
    }

    public Integer getTqaSomaVoz() {
        return this.tqaSomaVoz;
    }

    public void setTqaSomaVoz(Integer tqaSomaVoz) {
        this.tqaSomaVoz = tqaSomaVoz;
    }

	public Integer getTqaSomaTransmissao() {
		return tqaSomaTransmissao;
	}

	public void setTqaSomaTransmissao(Integer tqaSomaTransmissao) {
		this.tqaSomaTransmissao = tqaSomaTransmissao;
	}

	public Integer getTqaSomaDeterministica() {
		return tqaSomaDeterministica;
	}

	public void setTqaSomaDeterministica(Integer tqaSomaDeterministica) {
		this.tqaSomaDeterministica = tqaSomaDeterministica;
	}

	public Integer getTqaSomaSpeedy() {
		return tqaSomaSpeedy;
	}

	public void setTqaSomaSpeedy(Integer tqaSomaSpeedy) {
		this.tqaSomaSpeedy = tqaSomaSpeedy;
	}

	public Integer getTqaSomaCliente() {
		return tqaSomaCliente;
	}

	public void setTqaSomaCliente(Integer tqaSomaCliente) {
		this.tqaSomaCliente = tqaSomaCliente;
	}

	public Integer getTqaSomaCp() {
		return tqaSomaCp;
	}

	public void setTqaSomaCp(Integer tqaSomaCp) {
		this.tqaSomaCp = tqaSomaCp;
	}

	public Integer getTqaSomaRedeip() {
		return tqaSomaRedeip;
	}

	public void setTqaSomaRedeip(Integer tqaSomaRedeip) {
		this.tqaSomaRedeip = tqaSomaRedeip;
	}

	public Integer getTqaSomaInterconexao() {
		return tqaSomaInterconexao;
	}

	public void setTqaSomaInterconexao(Integer tqaSomaInterconexao) {
		this.tqaSomaInterconexao = tqaSomaInterconexao;
	}

	public Integer getTqaSomaSppac() {
		return tqaSomaSppac;
	}

	public void setTqaSomaSppac(Integer tqaSomaSppac) {
		this.tqaSomaSppac = tqaSomaSppac;
	}

	public Integer getTqaSomaDth() {
		return tqaSomaDth;
	}

	public void setTqaSomaDth(Integer tqaSomaDth) {
		this.tqaSomaDth = tqaSomaDth;
	}

	public Integer getTqaSomaFttx() {
		return tqaSomaFttx;
	}

	public void setTqaSomaFttx(Integer tqaSomaFttx) {
		this.tqaSomaFttx = tqaSomaFttx;
	}

	public Integer getTqaSomaIptv() {
		return tqaSomaIptv;
	}

	public void setTqaSomaIptv(Integer tqaSomaIptv) {
		this.tqaSomaIptv = tqaSomaIptv;
	}
}
