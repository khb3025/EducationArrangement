select employees.*,decode(job_id,'AD_VP',salary*1.2,salary*0.9) from employees;

select employees.*,decode(job_id,'AD_VP',salary*1.2,
                                 'IT_PROG',salary*1.1,
                                 'FI_ACCOUNT',salary*1.3,salary*1) from employees;

                            
                                 
                                 
select employees.*,case job_id when 'AD_VP' then salary*1.2
                   when 'IT_PROG' then salary*1.1
                   when 'FI_ACCOUNT' then salary*1.3
                   else salary
                   end
from employees;

select employees.*,case when job_id = 'AD_VP' then salary*1.2
                   when job_id ='IT_PROG' then salary*1.1
                   when job_id ='FI_ACCOUNT' then salary*1.3
                   else salary
                   end
from employees;


       
