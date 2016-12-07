import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import java.awt.Label;
import javax.swing.JTextField;
import javax.swing.JComboBox;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JButton;
import javax.swing.JScrollPane;
import javax.swing.border.LineBorder;
import java.awt.Color;
import javax.swing.JLayeredPane;
import javax.swing.ListSelectionModel;
import javax.swing.AbstractListModel;
import javax.swing.JRadioButtonMenuItem;
import java.awt.List;
import java.awt.Choice;
import java.awt.ScrollPane;
import javax.swing.JToolBar;
import java.awt.Window.Type;
import javax.swing.DefaultComboBoxModel;
import java.awt.event.ActionListener;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.awt.event.ActionEvent;

public class venIDE extends JFrame {

	private JPanel contentPane;
	private JTextField txtTopologia;
	private JTextField txtTamanhoDoBuffer;
	private JTextField txtTamanhoDoFlit;
	private JTextField txtProteo;
	

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					venIDE frame = new venIDE();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public venIDE() {
		setTitle("VENInterface");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		txtTopologia = new JTextField();
		txtTopologia.setEditable(false);
		txtTopologia.setText("Topologia :");
		txtTopologia.setBounds(10, 11, 116, 20);
		contentPane.add(txtTopologia);
		txtTopologia.setColumns(10);
		
		txtTamanhoDoBuffer = new JTextField();
		txtTamanhoDoBuffer.setEditable(false);
		txtTamanhoDoBuffer.setText("Tamanho do buffer :");
		txtTamanhoDoBuffer.setBounds(10, 59, 116, 20);
		contentPane.add(txtTamanhoDoBuffer);
		txtTamanhoDoBuffer.setColumns(10);
		
	
		
		txtTamanhoDoFlit = new JTextField();
		txtTamanhoDoFlit.setEditable(false);
		txtTamanhoDoFlit.setText("Tamanho do flit :");
		txtTamanhoDoFlit.setBounds(10, 112, 116, 20);
		contentPane.add(txtTamanhoDoFlit);
		txtTamanhoDoFlit.setColumns(10);
		
		txtProteo = new JTextField();
		txtProteo.setEditable(false);
		txtProteo.setText("Prote\u00E7\u00E3o :");
		txtProteo.setBounds(10, 167, 116, 20);
		contentPane.add(txtProteo);
		txtProteo.setColumns(10);
		
		// TOPOLOGIA
		JComboBox comboBox = new JComboBox();
		comboBox.setModel(new DefaultComboBoxModel(new String[] {"2x2", "3x3", "4x4"}));
		comboBox.setBounds(195, 11, 134, 20);
		contentPane.add(comboBox);
		
		//BUFFER
		JComboBox comboBox_1 = new JComboBox();
		comboBox_1.setModel(new DefaultComboBoxModel(new String[] {"16", "32"}));
		comboBox_1.setBounds(195, 59, 143, 20);
		contentPane.add(comboBox_1);
		
		//FLIT
		JComboBox comboBox_2 = new JComboBox();
		comboBox_2.setModel(new DefaultComboBoxModel(new String[] {"16", "32", "64"}));
		comboBox_2.setBounds(195, 112, 143, 20);
		contentPane.add(comboBox_2);
		
		JButton btnGerarNoc = new JButton("Gerar Noc");
		btnGerarNoc.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				createVHD(comboBox , comboBox_1 ,comboBox_2);
				JOptionPane.showMessageDialog(null,"ThorPackage.vhd Criado com sucesso!!");
			}
		});
		btnGerarNoc.setBounds(169, 227, 89, 23);
		contentPane.add(btnGerarNoc);
	}
	
	private void createVHD(JComboBox comboBox , JComboBox comboBox_1, JComboBox comboBox_2){
		String fileName = "Thor_package.vhd";
		try {
			File routingTable = new File(fileName);
            BufferedWriter bw = new BufferedWriter(new FileWriter(routingTable));
            writeRoutingTable(bw,comboBox , comboBox_1 ,comboBox_2);
            bw.flush();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
	
    private void writeRoutingTable(BufferedWriter bw, JComboBox comboBox , JComboBox comboBox_1, JComboBox comboBox_2) throws IOException {
    	writeRoutingTableHeader(bw);
        writeRoutingTableBody(bw,comboBox , comboBox_1 ,comboBox_2);
        writeRoutingTableTail(bw);
    }

    private void writeRoutingTableHeader(BufferedWriter bw) throws IOException {
        bw.append("library IEEE;\n"
        		  +"use IEEE.Std_Logic_1164.all;\n"
        		  +"use IEEE.numeric_std.all;\n \n"
        		  +"package NoCPackage is\n"
        		  +"-- Independent Constants ------------------ \n"
        		  +"    constant NPORT: integer := 5; \n"
        		  +"    constant EAST  : integer := 0;\n"
        		  +"    constant WEST  : integer := 1;\n"
        		  +"    constant NORTH : integer := 2;\n"
        		  +"    constant SOUTH : integer := 3;\n"
        		  +"    constant LOCAL : integer := 4;\n"
        		);
    }

    private void writeRoutingTableBody(BufferedWriter bw , JComboBox comboBox , JComboBox comboBox_1, JComboBox comboBox_2) throws IOException {
    	String topologia = comboBox.getSelectedItem().toString();
    	String buffer = comboBox_1.getSelectedItem().toString();	
    	String flit = comboBox_2.getSelectedItem().toString();
    	int dim_x = Integer.valueOf(topologia.split("x")[0]);
		int dim_y = Integer.valueOf(topologia.split("x")[1]);
    	bw.append("-- CONSTANTS RELATED TO THE NETWORK BANDWIDTH ------------------\n "
    			  +"\n"
    			  +"    constant TAM_FLIT : integer range 1 to 64 :="+ flit + "; \n"
    			  +"    constant METADEFLIT : integer range 1 to 32 := (TAM_FLIT/2);\n"
    			  +"    constant QUARTOFLIT : integer range 1 to 16 := (TAM_FLIT/4);\n"
    			  +"\n"
    			  + " -- CONSTANTS RELATED TO THE DEPTH OF THE QUEUE -------------\n"
    			  +"\n"
    			  +"    constant TAM_BUFFER: integer :="+ buffer +"; \n"
    			  +"    constant TAM_POINTER : integer range 1 to 32 := 5; \n"
    			  +"\n"
    			  +"-- CONSTANTS RELATED TO THE NUMBER OF ROUTERS ------------\n"
    			  +"\n "
    			  +"    constant NUM_X : integer :=" + dim_x +"; \n"
    			  +"    constant NUM_Y : integer :=" + dim_y +"; \n"
    			  +"    constant NROT: integer := NUM_X*NUM_Y; \n"
    			  +"    constant MIN_X : integer := 0;\n"
    			  +"    constant MIN_Y : integer := 0; \n"
    			  +"    constant MAX_X : integer := NUM_X-1;\n"
    			  +"    constant MAX_Y : integer := NUM_Y-1;\n"
    			  +"\n"
    			  +"-- NEW HARDWARE VARIABLES -------------\n"
    			  +" \n"
    			  +"    type RouterControl is (invalidRegion, validRegion, faultPort, portError); \n"
    			  +"\n"
    			  +"-- SUBTYPES, TYPES AND FUNCTIONS -----------\n"
    			  +" \n"
    			  +"    subtype reg3 is std_logic_vector(2 downto 0); \n"
    			  +"    subtype regNrot is std_logic_vector((NROT-1) downto 0); \n"
    			  +"    subtype regNport is std_logic_vector((NPORT-1) downto 0); \n"
    			  +"    subtype regflit is std_logic_vector((TAM_FLIT-1) downto 0); \n"
    			  +"    subtype regmetadeflit is std_logic_vector((METADEFLIT-1) downto 0); \n"
    			  +"    subtype regquartoflit is std_logic_vector((QUARTOFLIT-1) downto 0);\n"
    			  +"\n \n"
    			  +"    type arrayNport_reg3 is array((NPORT-1) downto 0) of reg3;\n"
    			  +"    type arrayNport_regflit is array((NPORT-1) downto 0) of regflit;\n"
    			  +"    type arrayNrot_regflit is array((NROT-1) downto 0) of regflit;\n"
    			  +"    type arrayNrot_regNport is array((NROT-1) downto 0) of regNport\n"
    			  +"    type matrixNrot_Nport_regflit is array((NROT-1) downto 0) of arrayNport_regflit;\n"
    			  +"\n"
    			  +"-- TB FUNCTIONS --------------\n"
    			  +"\n"
    			  +"    function ADDRESS_FROM_INDEX(index : integer) return regflit;\n"
    			  +"    function X_COORDINATE(address: regflit) return natural;\n "
    			  + "   function Y_COORDINATE(address: regflit) return natural;\n"
    			  +"    function OR_REDUCTION(arrayN : std_logic_vector ) return boolean;\n"
    			  +"\n"
    			  +"end NoCPackage;\n"
    			
    			
    			);
    	
    	
    	
    }

    private void writeRoutingTableTail(BufferedWriter bw) throws IOException {
        bw.append("\n"
                + "package body NoCPackage is\n"
        		+"\n"
        		+"    function ADDRESS_FROM_INDEX(index: integer) return regflit is\n"
                +"        variable addrX, addrY: regmetadeflit;\n"
        		+"        variable addr: regflit;\n"
                +"    begin\n"
        		+"        addrX := std_logic_vector(to_unsigned(index/NUM_X, METADEFLIT));\n"
                +"        addrY := std_logic_vector(to_unsigned(index mod NUM_Y, METADEFLIT));\n"
        		+"        addr := addrX & addrY;\n"
                +"        return addr;\n"
                +"    end ADDRESS_FROM_INDEX;\n"
                +"\n"
                +"    function X_COORDINATE(address: regflit) return natural is\n"
                +"    begin\n"
                +"        return TO_INTEGER(unsigned(address(TAM_FLIT-1 downto METADEFLIT)));\n"
                +"    end X_COORDINATE;\n"
                +"\n"
                +"    function Y_COORDINATE(address: regflit) return natural is\n"
                +"    begin\n"
                +"        return TO_INTEGER(unsigned(address(METADEFLIT-1 downto 0)));\n"
                +"    end Y_COORDINATE;\n"
                +"\n"
                +"     function OR_REDUCTION( arrayN: in std_logic_vector ) return boolean is\n"
                +"    begin\n"
                +"        return unsigned(arrayN) /= 0;\n"
                +"    end OR_REDUCTION;\n"
                +"\n"
                + "end NocPackage;\n");
    }
}